extends "res://Scenes/Towers/TowerMgr.gd"

func _ready():
	tower = "flame"
	fireLoc = $tSpace/Body/Head/Fire
	rangeNode = $RangeArea
	fireSound = $tSpace/Body/Head/Fire/FireSound
	upgrade = [0, 0]
	head = get_node("tSpace/Body/Head")
	price = GameData.towerData[tower]["price"]
	stats["Angle"] = GameData.towerData[tower]["angle"]
	stats["Damage"] = GameData.towerData[tower]["dmg"]
	stats["Attack Speed"] = GameData.towerData[tower]["as"]
	stats["Range"] = GameData.towerData[tower]["range"]
	stats["Bullet Speed"] = GameData.bulletData["bullet"]["speed"]

func _physics_process(_delta):
	if rangeNode.visibleEnemies.size() != 0 and built:
		enemySelection()
		if enemy != null:
			turn()




func specialUpgrade(tier, path):
	match path:
		1: match tier:
			1: 
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 14*64, 64, 64)
					1: head.texture.region = Rect2(0, 10*64, 64, 64)
					2: head.texture.region = Rect2(0, 11*64, 64, 64)
					3: head.texture.region = Rect2(0, 5*64, 64, 64)
					4: head.texture.region = Rect2(0, 8*64, 64, 64)
			2: 
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 15*64, 64, 64)
					1: head.texture.region = Rect2(0, 12*64, 64, 64)
					2: head.texture.region = Rect2(0, 13*64, 64, 64)
					3: head.texture.region = Rect2(0, 6*64, 64, 64)
					4: head.texture.region = Rect2(0, 9*64, 64, 64)
			3:
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 16*64, 64, 64)
					1: head.texture.region = Rect2(0, 17*64, 64, 64)
					2: head.texture.region = Rect2(0, 18*64, 64, 64)
			4:
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 19*64, 64, 64)
					1: head.texture.region = Rect2(0, 20*64, 64, 64)
					2: head.texture.region = Rect2(0, 21*64, 64, 64)
		2: match tier:
			1: 
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 2*64, 64, 64)
					1: head.texture.region = Rect2(0, 10*64, 64, 64)
					2: head.texture.region = Rect2(0, 12*64, 64, 64)
					3: head.texture.region = Rect2(0, 17*64, 64, 64)
					4: head.texture.region = Rect2(0, 20*64, 64, 64)
			2: 
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 3*64, 64, 64)
					1: head.texture.region = Rect2(0, 11*64, 64, 64)
					2: head.texture.region = Rect2(0, 13*64, 64, 64)
					3: head.texture.region = Rect2(0, 18*64, 64, 64)
					4: head.texture.region = Rect2(0, 21*64, 64, 64)
			3:
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 4*64, 64, 64)
					1: head.texture.region = Rect2(0, 5*64, 64, 64)
					2: head.texture.region = Rect2(0, 6*64, 64, 64)
			4:
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 7*64, 64, 64)
					1: head.texture.region = Rect2(0, 8*64, 64, 64)
					2: head.texture.region = Rect2(0, 9*64, 64, 64)
