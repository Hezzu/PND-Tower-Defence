extends Panel


func _ready():
	for i in $Upgrades.get_children():
		fillUpgradeInfo(i)


func fillUpgradeInfo(upg):
	upg.text = GameData.gameUpgradesData[upg.name]["text"] + "\n" + GameData.gameUpgradesData[upg.name]["textValue"] + "\n" + str(GameData.gameUpgradesData[upg.name]["price"]) + "UF"
	if GameData.gameUpgradesData[upg.name]["has"]:
		upg.text += "\nBought"
		upg.disabled = true


func _on_starting_cash_pressed():
	if get_parent().get_parent().ufTotal >= GameData.gameUpgradesData[$Upgrades/StartingCash.name]["price"]:
		GameData.gameUpgradesData["StartingCash"]["has"] = true
		fillUpgradeInfo($Upgrades/StartingCash)
		get_parent().get_parent().ufTotal -= GameData.gameUpgradesData[$Upgrades/StartingCash.name]["price"]
		get_parent().get_parent().updateUF()


func _on_exit_pressed():
	visible = false


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		save_dict[i] = GameData.gameUpgradesData[i]["has"]
	return save_dict
