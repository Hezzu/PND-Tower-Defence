extends "res://Scenes/Towers/TowerMgr.gd"

var bulletSpawn2
var fireCD2 = false
var bulletAnchor2
var muzzle2
var upgCheck = false

func _ready():
	tower = "turret"
	fireLoc = $tSpace/Body/Head/Fire
	bulletAnchor = $tSpace/Body/BulletAnchor
	muzzle = $tSpace/Body/Head/Muzzle
	muzzle2 = $tSpace/Body/Head/Muzzle2
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
					await(get_tree().create_timer(stats["Attack Speed"] / 2)).timeout
					x = 2
			2:
				if !fireCD2:
					fire2()
					await(get_tree().create_timer(stats["Attack Speed"] / 2)).timeout
					x = 1

func fire1():
	fireCD = true
	bulletSpawn = bullet.instantiate()
	bulletSpawn.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn.dmg = stats["Damage"] * GameData.towerData[tower]["dmgInc"]
	bulletSpawn.speed = stats["Bullet Speed"]
	bulletAnchor.set_global_position(fireLoc.get_global_position())
	bulletAnchor.rotation = head.rotation
	bulletAnchor.add_child(bulletSpawn)
	muzzle.play()
	fireSound.play()
	bulletSpawn.speed = stats["Bullet Speed"]
	await(get_tree().create_timer(stats["Attack Speed"])).timeout
	fireCD = false

func fire2():
	fireCD2 = true
	bulletSpawn2 = bullet.instantiate()
	bulletSpawn2.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn2.dmg = stats["Damage"] * GameData.towerData[tower]["dmgInc"]
	bulletSpawn2.speed = stats["Bullet Speed"]
	bulletAnchor2.set_global_position(fireLoc2.get_global_position())
	bulletAnchor2.rotation = head.rotation
	bulletAnchor2.add_child(bulletSpawn2)
	muzzle2.play()
	fireSound.play()
	bulletSpawn2.speed = stats["Bullet Speed"]
	await(get_tree().create_timer(stats["Attack Speed"])).timeout
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
				muzzle.position = fireLoc.position
				bulletAnchor2 = Marker2D.new()
				head.get_parent().add_child(bulletAnchor2)
				bulletAnchor2.position = Vector2(33, 6)
				head.add_child(fireLoc2)
				fireLoc2.position = Vector2(33, 6)
				muzzle2.position = fireLoc2.position
				fireSound.stream = load("res://Assets/Sounds/Towers/BaseTurret/Fire/Shoot High AS.wav")
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
				fireSound.stream = load("res://Assets/Sounds/Towers/BaseTurret/Fire/Shoot Sniper.wav")
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 7*64, 64, 64)
					1: head.texture.region = Rect2(0, 8*64, 64, 64)
					2: head.texture.region = Rect2(0, 9*64, 64, 64)
