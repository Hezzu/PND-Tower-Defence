extends Panel

var uf

func _ready():
	for i in $Upgrades.get_children():
		fillUpgradeInfo(i)
	uf = get_parent().ufTotal
	updateUF()

func updateUF():
	$UF.text = "UF: " + str(uf)


func fillUpgradeInfo(upg):
	upg.text = GameData.gameUpgradesData[upg.name]["text"] + "\n" + GameData.gameUpgradesData[upg.name]["textValue"] + "\n" + str(GameData.gameUpgradesData[upg.name]["price"]) + "UF"
	if GameData.gameUpgradesData[upg.name]["has"]:
		upg.text += "\nBought"
		upg.disabled = true


func _on_starting_cash_pressed():
	if uf >= GameData.gameUpgradesData[$Upgrades/StartingCash.name]["price"]:
		GameData.gameUpgradesData["StartingCash"]["has"] = true
		fillUpgradeInfo($Upgrades/StartingCash)
		uf -= GameData.gameUpgradesData[name]["price"]
		updateUF()


func _on_exit_pressed():
	get_parent().ufTotal = uf
	queue_free()


func save():
	var save_dict = {}
	for i in GameData.gameUpgradesData:
		save_dict[i.name] = GameData.gameUpgradesData[i.name]["has"]
	return save_dict
