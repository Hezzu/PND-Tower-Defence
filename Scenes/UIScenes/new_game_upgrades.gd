extends Panel
signal left()

#@onready var upgsNode = $Control/MarginContainer/Upgrades
var ufInfo
var iTitle
var iInfo
var iReqs
var iPrice
var iBtn
var cId

var ufNode

var uf = 0

func _ready():
	ufInfo = $CanvasLayer/MarginContainer/UFInfo
	iTitle = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Title
	iInfo = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Info
	iReqs = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Reqs
	iPrice = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Price
	iBtn = $CanvasLayer/MarginContainer/UFInfo/MarginContainer/VBoxContainer/Button
	ufNode = $CanvasLayer/MarginContainer/UF
	for i in get_tree().get_nodes_in_group("ufuNode"):
		i.pressed.connect(_on_node_pressed.bind(i.name))
	get_tree().create_timer(0.1).timeout.connect(nodeUpdate)
	

func updateUF():
	ufNode.text = "UF: " + str(uf)
	pass

func _on_exit_pressed():
	visible = false
	$CanvasLayer.visible = false
	$upgCam.enabled = false
	get_parent().get_parent().ufTotal = uf
	get_parent().get_parent().updateUF()


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		if !save_dict.has(i):
			save_dict[i] = [ GameData.gameUpgradesData[i]["bought"], GameData.gameUpgradesData[i]["enabled"],  GameData.gameUpgradesData[i]["oneshot"]]
	return save_dict

func _on_node_pressed(id):
	cId = id
	iTitle.text = GameData.gameUpgradesData[id]["title"]
	iInfo.text = GameData.gameUpgradesData[id]["info"]
	iPrice.text = str(GameData.gameUpgradesData[id]["price"]) + "$"
	if !GameData.gameUpgradesData[id]["requirements"] == null:
		for i in GameData.gameUpgradesData[id]["requirements"]:
			if !GameData.gameUpgradesData[i]["bought"]:
				iReqs.visible = true
				iBtn.disabled = true
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
	if uf >= GameData.gameUpgradesData[cId]["price"] and !GameData.gameUpgradesData[cId]["bought"]:
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
					applyUpgs(-1, j)
		nodeUpdate()
	applyUpgs(turn, cId)

func applyUpgs(turn, id):
	match GameData.gameUpgradesData[id]["type"]:
				"SMU":
					GameData.gameData["StartMoney"] += turn * GameData.gameUpgradesData[id]["value"]
				"CPWU":
					GameData.gameData["CashPerWave"] += turn * GameData.gameUpgradesData[id]["value"]
				"IU":
					GameData.gameData["Interest"] += turn * GameData.gameUpgradesData[id]["value"]
				"MS":
					GameData.gameData["MaxSpeed"] +=  turn * GameData.gameUpgradesData[id]["value"]
				"StatBuff":
					match GameData.gameUpgradesData[id]["for"][0]:
						"tower":
							GameData.towerData[GameData.gameUpgradesData[id]["for"][1]][GameData.gameUpgradesData[id]["for"][2]] += turn * GameData.gameUpgradesData[id]["value"]
						"bullet":
							GameData.bulletData[GameData.gameUpgradesData[id]["for"][1]][GameData.gameUpgradesData[id]["for"][2]] += turn * GameData.gameUpgradesData[id]["value"]
				"SRU":
					GameData.gameData["WaveSkipRatio"] += turn * GameData.gameUpgradesData[id]["value"]
				"Unlock":
					match GameData.gameUpgradesData[id]["for"][0]:
						"tower":
							GameData.towerData[GameData.gameUpgradesData[id]["for"][1]]["unlocked"] = true
						"diff":
							GameData.diffData[GameData.gameUpgradesData[id]["for"][1]]["unlocked"] = true
