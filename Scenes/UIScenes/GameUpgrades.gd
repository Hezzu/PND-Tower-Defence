extends Panel

@onready var ufNode = $Control/CanvasLayer/MarginContainer/UF
var uf = 0

func _ready():
	for i in get_tree().get_nodes_in_group("gUpg"):
		fillUpgradeInfo(i)

func updateUF():
	ufNode.text = "UF: " + str(uf)
	pass

func fillUpgradeInfo(upg):
	upg.text = GameData.gameUpgradesData[upg.name]["text"] + "\n" + GameData.gameUpgradesData[upg.name]["textValue"] + "\n" + str(GameData.gameUpgradesData[upg.name]["price"]) + "UF"
	if GameData.gameUpgradesData[upg.name]["has"]:
		upg.text += "\nBought"
		upg.disabled = true
		for child in upg.get_children():
			child.default_color = Color("ffffff")


func _on_exit_pressed():
	visible = false
	$Control/CanvasLayer.visible = false
	$Control/upgCam.enabled = false
	get_parent().get_parent().ufTotal = uf
	get_parent().get_parent().updateUF()


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		save_dict[i] = GameData.gameUpgradesData[i]["has"]
	return save_dict

func _on_starting_cash_pressed():
	if uf >= GameData.gameUpgradesData[$Control/StartingCash.name]["price"]:
		GameData.gameUpgradesData["StartingCash"]["has"] = true
		fillUpgradeInfo($Control/StartingCash)
		uf -= GameData.gameUpgradesData[$Control/StartingCash.name]["price"]
		updateUF()


func _on_cash_multi_up_pressed():
	if uf >= GameData.gameUpgradesData[$Control/CashMultiUp.name]["price"] and GameData.gameUpgradesData["StartingCash"]["has"]:
		GameData.gameUpgradesData["CashMultiUp"]["has"] = true
		fillUpgradeInfo($Control/CashMultiUp)
		uf -= GameData.gameUpgradesData[$Control/CashMultiUp.name]["price"]
		updateUF()
