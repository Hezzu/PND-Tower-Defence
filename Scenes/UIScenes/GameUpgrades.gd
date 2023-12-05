extends Panel


func _ready():
	for i in $Upgrades.get_children():
		fillUpgradeInfo(i)


func fillUpgradeInfo(upg):
	upg.text = GameData.gameUpgradesData[upg.name]["text"] + "\n" + GameData.gameUpgradesData[upg.name]["textValue"] + "\n" + str(GameData.gameUpgradesData[upg.name]["price"]) + "UF"
	if GameData.gameUpgradesData[upg.name]["has"]:
		upg.text += "\nBought"
		upg.disabled = true
		for child in upg.get_children():
			child.default_color = Color("ffffff")


func _on_exit_pressed():
	visible = false


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		save_dict[i] = GameData.gameUpgradesData[i]["has"]
	return save_dict

func _on_starting_cash_pressed():
	if get_parent().get_parent().ufTotal >= GameData.gameUpgradesData[$Upgrades/StartingCash.name]["price"]:
		GameData.gameUpgradesData["StartingCash"]["has"] = true
		fillUpgradeInfo($Upgrades/StartingCash)
		get_parent().get_parent().ufTotal -= GameData.gameUpgradesData[$Upgrades/StartingCash.name]["price"]
		get_parent().get_parent().updateUF()


func _on_cash_multi_up_pressed():
	if get_parent().get_parent().ufTotal >= GameData.gameUpgradesData[$Upgrades/CashMultiUp.name]["price"] and GameData.gameUpgradesData["StartingCash"]["has"]:
		GameData.gameUpgradesData["CashMultiUp"]["has"] = true
		fillUpgradeInfo($Upgrades/CashMultiUp)
		get_parent().get_parent().ufTotal -= GameData.gameUpgradesData[$Upgrades/CashMultiUp.name]["price"]
		get_parent().get_parent().updateUF()
