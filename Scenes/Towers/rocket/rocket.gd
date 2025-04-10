extends "res://Scenes/Towers/TowerMgr.gd"

var upgCheck = false
var newMissle = preload("res://Scenes/Towers/Bullets/rocket.tscn")
var baseMissile = preload("res://Assets/Sounds/Towers/Rocket/Explosion/Explosion.wav")
var nukeMissile = preload("res://Assets/Sounds/Towers/Rocket/Explosion/Explosion Nuke.wav")
var fastMissile = preload("res://Assets/Sounds/Towers/Rocket/Explosion/Explosion Fast.wav")
var cMS
var bulletAnchor2
var fireCD2 = false
var rocketType = 0
var superRocket = false

func _ready():
	tower = "rocket"
	upgrade = [0, 0]
	head = get_node("tSpace/Body/Head")
	rangeNode = $RangeArea
	bulletAnchor = $tSpace/Body/bulletAnchor
	cMS = baseMissile
	price = GameData.towerData[tower]["price"]
	stats["Area of Effect"] = GameData.bulletData["missle"]["aoe"]
	stats["Angle"] = GameData.towerData[tower]["angle"]
	stats["Damage"] = GameData.towerData[tower]["dmg"]
	stats["Attack Speed"] = GameData.towerData[tower]["as"]
	stats["Range"] = GameData.towerData[tower]["range"]
	stats["Bullet Speed"] = GameData.bulletData["missle"]["speed"]
	missle = $tSpace/Body/bulletAnchor/rocket
	missle.setAOE(stats["Area of Effect"])

func _physics_process(_delta):
	if rangeNode.visibleEnemies.size() != 0 and built:
		enemySelection()
		if enemy != null:
			if !upgCheck:
				turn()
			else:
				turn2()


func turn():
	head.look_at(enemy.position)
	if !fireCD:
		bulletAnchor.rotation = head.rotation
	if !fireCD:
			fire()


var x = 1
func turn2():
	head.look_at(enemy.position)
	bulletAnchor.look_at(enemy.position)
	bulletAnchor2.look_at(enemy.position)
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

func fire():
	fireCD = true
	rocketStart(missle)
	await(get_tree().create_timer(stats["Attack Speed"] - 0.2)).timeout
	missle = newMissle.instantiate()
	if superRocket:
		rocketReady(bulletAnchor, missle, Vector2(0, 0))
	else:
		rocketReady(bulletAnchor, missle)
	await(get_tree().create_timer(0.2)).timeout
	bulletAnchor.rotation = head.rotation
	fireCD = false

func fire1():
	fireCD = true
	rocketStart(missle)
	await(get_tree().create_timer((stats["Attack Speed"]) - 0.2)).timeout
	missle = newMissle.instantiate()
	rocketReady(bulletAnchor, missle, Vector2(10, -6))
	await(get_tree().create_timer(0.2)).timeout
	bulletAnchor.rotation = head.rotation
	fireCD = false
func fire2():
	fireCD2 = true
	rocketStart(missle2)
	await(get_tree().create_timer(stats["Attack Speed"] - 0.2)).timeout
	missle2 = newMissle.instantiate()
	rocketReady(bulletAnchor2, missle2, Vector2(10, 6))
#	missle2 = newMissle.instantiate()
#	missle2.setAOE(aoeRad)
#	missle2.position = Vector2(10, -7)
#	bulletAnchor2.rotation = head.rotation
#	bulletAnchor2.add_child(missle2)
	await(get_tree().create_timer(0.2)).timeout
	bulletAnchor2.rotation = head.rotation
	fireCD2 = false

func rocketReady(anchor, missile, pos = Vector2(10, 0)):
	anchor.add_child(missile)
	missile.setAOE(stats["Area of Effect"])
	missile.get_node("Sprite2D").texture.region = Rect2(0, rocketType, 64, 64)
	missile.position = pos
	anchor.rotation = head.rotation

func rocketStart(body):
	body.hitSound.stream = cMS
	body.dmg = stats["Damage"]
	body.rocketStart(Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90)))
	body.speed = stats["Bullet Speed"]


func specialUpgrade(tier, path):
	match path:
		1: match tier:
			1:
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 2*64, 64, 64)
					1: head.texture.region = Rect2(0, 10*64, 64, 64)
					2: head.texture.region = Rect2(0, 11*64, 64, 64)
					3: head.texture.region = Rect2(0, 18*64, 64, 64)
					4: head.texture.region = Rect2(0, 20*64, 64, 64)
			2:
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 3*64, 64, 64)
					1: head.texture.region = Rect2(0, 12*64, 64, 64)
					2: head.texture.region = Rect2(0, 13*64, 64, 64)
					3: head.texture.region = Rect2(0, 19*64, 64, 64)
					4:
						head.texture.region = Rect2(0, 21*64, 64, 64)
						head.get_parent().move_child(head, 0)
			3:
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 4*64, 64, 64)
					1: head.texture.region = Rect2(0, 14*64, 64, 64)
					2: head.texture.region = Rect2(0, 15*64, 64, 64)
			4: 
				match upgrade[1]:
					0: head.texture.region = Rect2(0, 5*64, 64, 64)
					1: head.texture.region = Rect2(0, 16*64, 64, 64)
					2: head.texture.region = Rect2(0, 17*64, 64, 64)
				cMS = fastMissile
				bulletAnchor2 = Marker2D.new()
				head.get_parent().add_child(bulletAnchor2)
				head.get_parent().move_child(bulletAnchor2, 1)
				if missle != null and !missle.start:
					missle.queue_free()
					missle = newMissle.instantiate()
					rocketReady(bulletAnchor, missle, Vector2(10, -6))
				missle2 = newMissle.instantiate()
				rocketReady(bulletAnchor2, missle2, Vector2(10, 6))
				upgCheck = true
#				var upgraded = load("res://Scenes/Towers/rocket/rocket[01].tscn").instantiate()
#				upgraded.passParams(dmg, range, attackSpeed, bSpeed, angle, upgrade, rotation, price, rangeNode.visibleEnemies, aoeRad)
#				upgraded.position = position
#				upgraded.ifDraw = true
#				upgraded.showPlacementArea = true
#				emit_signal("superUpgrade", upgraded)
#				emit_signal("changeNode", upgraded)
#				get_parent().add_child(upgraded)
#				queue_free()
		2: match tier:
			1:
				rocketType = 1*64
				if missle != null and !missle.start:
					missle.queue_free()
					missle = newMissle.instantiate()
					rocketReady(bulletAnchor, missle)
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 6*64, 64, 64)
					1: head.texture.region = Rect2(0, 10*64, 64, 64)
					2: head.texture.region = Rect2(0, 12*64, 64, 64)
					3: head.texture.region = Rect2(0, 14*64, 64, 64)
					4: 
						head.texture.region = Rect2(0, 16*64, 64, 64)
						if missle2 != null:
							missle2.queue_free()
							missle2 = newMissle.instantiate()
							rocketReady(bulletAnchor2, missle2, Vector2(10, 6))
						if missle != null:
							missle.queue_free()
							missle = newMissle.instantiate()
							rocketReady(bulletAnchor, missle, Vector2(10, -6))
				
			2:
				rocketType = 2*64
				if missle != null and !missle.start:
					missle.queue_free()
					missle = newMissle.instantiate()
					rocketReady(bulletAnchor, missle)
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 7*64, 64, 64)
					1: head.texture.region = Rect2(0, 11*64, 64, 64)
					2: head.texture.region = Rect2(0, 13*64, 64, 64)
					3: head.texture.region = Rect2(0, 15*64, 64, 64)
					4: 
						head.texture.region = Rect2(0, 17*64, 64, 64)
						if missle2 != null and !missle2.start:
							missle2.queue_free()
							missle2 = newMissle.instantiate()
							rocketReady(bulletAnchor2, missle2, Vector2(10, 6))
						if missle != null and !missle.start:
							missle.queue_free()
							missle = newMissle.instantiate()
							rocketReady(bulletAnchor, missle, Vector2(10, -6))
			3:
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 8*64, 64, 64)
					1: head.texture.region = Rect2(0, 18*64, 64, 64)
					2: head.texture.region = Rect2(0, 19*64, 64, 64)
				rocketType = 3*64
				if missle != null and !missle.start:
					missle.queue_free()
					missle = newMissle.instantiate()
					rocketReady(bulletAnchor, missle)
				
			4: 
				match upgrade[0]:
					0: head.texture.region = Rect2(0, 9*64, 64, 64)
					1: head.texture.region = Rect2(0, 20*64, 64, 64)
					2:
						head.texture.region = Rect2(0, 21*64, 64, 64)
						head.get_parent().move_child(head, 0)
				rocketType = 4*64
				
				if missle != null and !missle.start:
					missle.queue_free()
					missle = newMissle.instantiate()
					rocketReady(bulletAnchor, missle, Vector2(0, 0))
				cMS = nukeMissile
				superRocket = true
#passParams(nDmg, nRange, nAttackSpeed, nBS, nAngle, nUpgrades, nRotation, nAOE = 0, nFireLoc1 = null, nFireLoc2 = null)
