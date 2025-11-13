extends Control
signal leave()

var pathPane
var gDiff

func _ready():
	pathPane = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer

func _on_exit_pressed():
	emit_signal("leave")

func fillInfo(tower):
	for i in GameData.upgradeData[tower]:
		for j in GameData.upgradeData[tower][i]:
			var temp = pathPane.get_node(i + "Pane/" + i + "/T" + str(j))
			temp.text = "Tier " + str(j)
			for n in GameData.upgradeData[tower][i][j]:
				match(n):
					"Name":
						temp.text +=  "\n" + GameData.upgradeData[tower][i][j][n]
					"Attack Speed":
						if GameData.upgradeData[tower][i][j][n] < 0:
							temp.text +=  "\n" + n + ": " + str(GameData.upgradeData[tower][i][j][n])
						else:
							temp.text +=  "\n" + n + ": +" + str(GameData.upgradeData[tower][i][j][n])
							
					"price":
						temp.text +=  "\nPrice: " + str(GameData.upgradeData[tower][i][j][n]*GameData.diffData[gDiff]["priceMod"]) + "$"
					"Percentage Damage":
						temp.text +=  "\n% Damage: +" + str(GameData.upgradeData[tower][i][j][n] * 100) + "%"
					"Damage":
						temp.text +=  "\n" + n + ": +" + str(GameData.upgradeData[tower][i][j][n] * GameData.towerData[tower]["dmgInc"])
					_:
						temp.text +=  "\n" + n + ": +" + str(GameData.upgradeData[tower][i][j][n])
				


func _on_tower_select_pressed(extra_arg_0):
	fillInfo(extra_arg_0)
