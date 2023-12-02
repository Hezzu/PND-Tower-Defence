extends Panel

func _ready():
	for i in $Upgrades.get_children():
		fillUpgradeInfo(i)


func fillUpgradeInfo(upg):
	upg.text = GameData.gameUpgradesData[upg.name]["text"] + "\n" + str(GameData.gameUpgradesData[upg.name]["value"])
	if GameData.gameUpgradesData[upg.name]["has"]:
		upg.text += "\nBought"
		upg.disabled = true


func _on_starting_cash_pressed():
	GameData.gameUpgradesData["StartingCash"]["has"] = true
	fillUpgradeInfo($Upgrades/StartingCash)


func _on_exit_pressed():
	queue_free()
