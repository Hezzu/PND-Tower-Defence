extends "res://Scenes/Towers/TowerMgr.gd"


func _ready():
	tower = "turret"
	fireLoc = $tSpace/Body/Head/Fire
	upgrade = [0, 0]
	head = get_node("tSpace/Body/Head")
	angle = GameData.towerData[tower]["angle"]
	dmg = GameData.towerData[tower]["dmg"]
	attackSpeed = GameData.towerData[tower]["as"]
	range = GameData.towerData[tower]["range"]
	bSpeed = GameData.bulletData["bullet"]["speed"]

func specialUpgrade(tier, path):
	match path:
		1: match tier:
			3:
				var upgraded = load("res://Scenes/Towers/turret/turret[01].tscn").instantiate()
				upgraded.passParams(dmg, range, attackSpeed, bSpeed, angle, upgrade, rotation, price, rangeNode.visibleEnemies)
				upgraded.position = position
				upgraded.ifDraw = true
				upgraded.showPlacementArea = true
				emit_signal("superUpgrade", upgraded)
				emit_signal("changeNode", upgraded)
				get_parent().add_child(upgraded)
				queue_free()
			4:
				pass
		2: match tier:
			3:
				pass
			4: 
				pass
