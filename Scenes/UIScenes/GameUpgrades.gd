extends Panel

@onready var upgsNode = $Control/MarginContainer/Upgrades
@onready var ufNode = $Control/CanvasLayer/MarginContainer/UF
var uf = 0

func _ready():
	for i in GameData.gameUpgradesData:
		for j in GameData.gameUpgradesData[i]:
			fillUpgradeInfo(j, i)

func updateUF():
	ufNode.text = "UF: " + str(uf)
	pass

func fillUpgradeInfo(id, set):
	var setId = GameData.gameUpgradesData.keys().find(set)
	var upg = upgsNode.get_child(setId).get_child(id - 1)
	upg.text = GameData.gameUpgradesData[set][id]["text"] + "\n" + GameData.gameUpgradesData[set][id]["textValue"] + "\n" + str(GameData.gameUpgradesData[set][id]["price"]) + "UF"
	if GameData.gameUpgradesData[set][id]["has"]:
		upg.text += "\nBought"
		upg.self_modulate = Color("54e500")
		for child in upg.get_children():
			child.default_color = Color("ffffff")
	if GameData.gameUpgradesData[set][id]["previousHas"]:
		upg.disabled = false
	else:
		upg.disabled = true


func _on_exit_pressed():
	visible = false
	$Control/CanvasLayer.visible = false
	$Control/upgCam.enabled = false
	get_parent().get_parent().ufTotal = uf
	get_parent().get_parent().updateUF()


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		if !save_dict.has(i):
			save_dict[i] = GameData.gameUpgradesData[i]
			print(save_dict)
		for j in GameData.gameUpgradesData[i]:
			save_dict[i][j] = GameData.gameUpgradesData[i][j]["has"]
	return save_dict


func _on_upgrade_pressed(id, set):
	if uf >= GameData.gameUpgradesData[set][id]["price"] and !GameData.gameUpgradesData[set][id]["has"]:
		GameData.gameUpgradesData[set][id]["has"] = true
		if !GameData.gameUpgradesData[set][id]["last"]:
			GameData.gameUpgradesData[set][id + 1]["previousHas"] = true
			fillUpgradeInfo(id+1, set)
		fillUpgradeInfo(id, set)
		uf -= GameData.gameUpgradesData[set][id]["price"]
		updateUF()
