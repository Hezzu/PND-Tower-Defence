extends Panel
signal left()

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
	var upg = upgsNode.get_child(setId).get_child(id)
	upg.text = GameData.gameUpgradesData[set][id]["text"] + "\n" + GameData.gameUpgradesData[set][id]["textValue"]
	if GameData.gameUpgradesData[set][id]["has"]:
		upg.text += "\nBought"
		for child in upg.get_children():
			child.modulate = Color("00ff00")
		if GameData.gameUpgradesData[set][id]["turned"]:
			upg.self_modulate = Color("54e500")
			upg.text += "\nActive: Yes"
		else:
			upg.self_modulate = Color("ff403e")
			upg.text += "\nActive: No"
	else:
		upg.text += "\n" + str(GameData.gameUpgradesData[set][id]["price"]) + "UF"
	if GameData.gameUpgradesData[set][id]["previousHas"]:
		upg.disabled = false
	else:
		upg.disabled = true


func _on_exit_pressed():
	visible = false
	emit_signal("left")
	$Control/CanvasLayer.visible = false
	$Control/upgCam.enabled = false
	get_parent().get_parent().ufTotal = uf
	get_parent().get_parent().updateUF()


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		if !save_dict.has(i):
			save_dict[i] = GameData.gameUpgradesData[i]
		for j in GameData.gameUpgradesData[i]:
			save_dict[i][j] = GameData.gameUpgradesData[i][j]["has"]
	return save_dict


func _on_upgrade_pressed(id, set):
	if !GameData.gameUpgradesData[set][id]["has"] and uf >= GameData.gameUpgradesData[set][id]["price"]:
		GameData.gameUpgradesData[set][id]["has"] = true
		GameData.gameUpgradesData[set][id]["turned"] = true
		if !GameData.gameUpgradesData[set][id]["last"]:
			GameData.gameUpgradesData[set][id + 1]["previousHas"] = true
			fillUpgradeInfo(id+1, set)
		fillUpgradeInfo(id, set)
		uf -= GameData.gameUpgradesData[set][id]["price"]
		updateUF()
		updateGameData(set, id, 1)
	else:
		GameData.gameUpgradesData[set][id]["turned"] = !GameData.gameUpgradesData[set][id]["turned"]
		if GameData.gameUpgradesData[set][id]["turned"]:
			updateGameData(set, id, 1)
		else:
			updateGameData(set, id, -1)
		fillUpgradeInfo(id, set)

func updateGameData(set, id, turn):
	match GameData.gameUpgradesData[set][id]["type"]:
			"StartMoney":
				GameData.gameData["StartMoney"] += turn * GameData.gameUpgradesData[set][id]["value"]
			"CashPerWave":
				GameData.gameData["CashPerWave"] += turn * GameData.gameUpgradesData[set][id]["value"]
			"MaxSpeed":
				GameData.gameData["MaxSpeed"] +=  turn * GameData.gameUpgradesData[set][id]["value"]
			"DmgInc":
				GameData.bulletData[GameData.gameUpgradesData[set][id]["for"]]["dmgInc"] += turn * GameData.gameUpgradesData[set][id]["value"]
			"aoeMod":
				GameData.bulletData[GameData.gameUpgradesData[set][id]["for"]]["aoeMod"] += turn * GameData.gameUpgradesData[set][id]["value"]
			"statBuff":
				GameData.towerData[GameData.gameUpgradesData[set][id]["tower"]][GameData.gameUpgradesData[set][id]["for"]] += turn * GameData.gameUpgradesData[set][id]["value"]
			"SkipRatio":
				GameData.gameData["WaveSkipRatio"] += turn * GameData.gameUpgradesData[set][id]["value"]
			"InterestUp":
				GameData.gameData["Interest"] += turn * GameData.gameUpgradesData[set][id]["value"]
