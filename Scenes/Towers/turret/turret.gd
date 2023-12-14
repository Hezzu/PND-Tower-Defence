extends "res://Scenes/Towers/TowerMgr.gd"


var bulletSpawn2
var fireCD2 = false
var bulletAnchor2
var upgCheck = false

func _ready():
	tower = "turret"
	fireLoc = $tSpace/Body/Head/Fire
	bulletAnchor = $tSpace/Body/BulletAnchor
	upgrade = [0, 0]
	head = get_node("tSpace/Body/Head")
	angle = GameData.towerData[tower]["angle"]
	dmg = GameData.towerData[tower]["dmg"]
	attackSpeed = GameData.towerData[tower]["as"]
	range = GameData.towerData[tower]["range"]
	bSpeed = GameData.bulletData["bullet"]["speed"]

func _physics_process(delta):
	if rangeNode.visibleEnemies.size() != 0 and built:
		enemySelection()
		if enemy != null:
			if !upgCheck:
				turn()
			else:
				turn2()


var x = 1
func turn2():
	head.look_at(enemy.position)
	if !fireCD or !fireCD2:
		match x:
			1:
				if !fireCD:
					fire1()
					await(get_tree().create_timer(attackSpeed / 2)).timeout
					x = 2
			2:
				if !fireCD2:
					fire2()
					await(get_tree().create_timer(attackSpeed / 2)).timeout
					x = 1

func fire1():
	fireCD = true
	bulletSpawn = bullet.instantiate()
	bulletSpawn.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn.dmg = dmg
	bulletSpawn.speed = bSpeed
	bulletAnchor.set_global_position(fireLoc.get_global_position())
	bulletAnchor.rotation = head.rotation
	bulletAnchor.add_child(bulletSpawn)
	bulletSpawn.speed = bSpeed
	await(get_tree().create_timer(attackSpeed)).timeout
	fireCD = false

func fire2():
	fireCD2 = true
	bulletSpawn2 = bullet.instantiate()
	bulletSpawn2.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn2.dmg = dmg
	bulletSpawn2.speed = bSpeed
	bulletAnchor2.set_global_position(fireLoc2.get_global_position())
	bulletAnchor2.rotation = head.rotation
	bulletAnchor2.add_child(bulletSpawn2)
	bulletSpawn2.speed = bSpeed
	await(get_tree().create_timer(attackSpeed)).timeout
	fireCD2 = false









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
				fireLoc.position = Vector2(33, -6)
				fireLoc2 = Marker2D.new()
				bulletAnchor.position = Vector2(33, -6)
				bulletAnchor2 = Marker2D.new()
				head.get_parent().add_child(bulletAnchor2)
				bulletAnchor2.position = Vector2(33, 6)
				head.add_child(fireLoc2)
				fireLoc2.position = Vector2(33, 6)
				upgCheck = true
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
