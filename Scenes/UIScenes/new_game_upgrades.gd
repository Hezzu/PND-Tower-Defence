extends Panel
signal left(uf: int)

#@onready var upgsNode = $Control/MarginContainer/Upgrades
var ufInfo
var iTitle
var iInfo
var iReqs
var iPrice
var iBtn
var cId
var upgCam

var ufNode

var failAudio
var SuccessAudio


var uf = 0

func _ready():
	ufInfo = $CanvasLayer/MarginContainer/UFInfo
	iTitle = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Title
	iInfo = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Info
	iReqs = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Reqs
	iPrice = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Price
	iBtn = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Button
	ufNode = $CanvasLayer/MarginContainer/UF
	upgCam = $upgCam
	SuccessAudio = $SucA
	failAudio = $FailA
	for i in get_tree().get_nodes_in_group("ufuNode"):
		i.pressed.connect(_on_node_pressed.bind(i.name))
	get_tree().create_timer(0.1).timeout.connect(nodeUpdate)
	

func cameraSwitch():
	upgCam.enabled = !upgCam.enabled

func updateUF():
	ufNode.text = "UF: " + str(uf)
	pass

func _on_exit_pressed():
	cameraSwitch()
	emit_signal("left", uf)


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		if !save_dict.has(i):
			save_dict[i] = [ GameData.gameUpgradesData[i]["bought"], GameData.gameUpgradesData[i]["enabled"],  GameData.gameUpgradesData[i]["oneshot"]]
	return save_dict

func _on_node_pressed(id):
	SuccessAudio.play()
	cId = id
	iTitle.text = GameData.gameUpgradesData[id]["title"]
	iInfo.text = GameData.gameUpgradesData[id]["info"]
	iPrice.text = str(GameData.gameUpgradesData[id]["price"]) + " UF"
	if !GameData.gameUpgradesData[id]["requirements"] == null:
		var status = true
		for i in GameData.gameUpgradesData[id]["requirements"]:
			if !GameData.gameUpgradesData[i]["bought"]:
				status = false
		iReqs.visible = !status
		iBtn.disabled = !status
	else:
			iReqs.visible = false
			iBtn.disabled = false
	if !GameData.gameUpgradesData[id]["bought"]:
		iBtn.text = "Buy"
		iBtn.self_modulate = Color("ffffff")
	elif GameData.gameUpgradesData[id]["oneshot"]:
		iBtn.text = "Enabled"
		iBtn.self_modulate = Color("54e500")
	elif GameData.gameUpgradesData[id]["enabled"]:
		iBtn.text = "Disable"
		iBtn.self_modulate = Color("54e500")
	else:
		iBtn.text = "Enable"
		iBtn.self_modulate = Color("ff403e")
	ufInfo.visible = true

func nodeUpdate():
	for i in get_tree().get_nodes_in_group("ufuNode"):
		if GameData.gameUpgradesData[i.name]["bought"]:
			if GameData.gameUpgradesData[i.name]["enabled"]:
				i.self_modulate = Color("54e500")
				i.get_parent().self_modulate = Color("54e500")
			else:
				i.self_modulate = Color("ff403e")
				i.get_parent().self_modulate = Color("ff403e")

func iBtnPressed():
	if uf < GameData.gameUpgradesData[cId]["price"] and !GameData.gameUpgradesData[cId]["bought"]:
		failAudio.play()
	elif uf >= GameData.gameUpgradesData[cId]["price"] and !GameData.gameUpgradesData[cId]["bought"]:
		uf -= GameData.gameUpgradesData[cId]["price"]
		updateUF()
		GameData.gameUpgradesData[cId]["bought"] = true
		GameData.gameUpgradesData[cId]["enabled"] = true
		_on_node_pressed(cId)
		nodeUpdate()
		checkEx(1)
	elif GameData.gameUpgradesData[cId]["enabled"] and !GameData.gameUpgradesData[cId]["oneshot"]:
		GameData.gameUpgradesData[cId]["enabled"] = false
		_on_node_pressed(cId)
		checkEx(-1)
		nodeUpdate()
	else:
		GameData.gameUpgradesData[cId]["enabled"] = true
		_on_node_pressed(cId)
		nodeUpdate()
		checkEx(1)

func checkEx(turn):
	if !GameData.gameUpgradesData[cId]["exclusive"] == null and turn == 1:
		for i in GameData.gameUpgradesData[cId]["exclusive"]:
			for j in GameData.gameUpgradesData:
				if GameData.gameUpgradesData[j]["type"] == i and j != cId and GameData.gameUpgradesData[j]["enabled"]:
					GameData.gameUpgradesData[j]["enabled"] = false
					GameData.applyUpgs(-1, j)
		nodeUpdate()
	GameData.applyUpgs(turn, cId)
