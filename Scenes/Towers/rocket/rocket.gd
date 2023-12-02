extends "res://Scenes/Towers/TowerMgr.gd"


var newMissle = preload("res://Scenes/Towers/Bullets/rocket.tscn")

func _ready():
	tower = "rocket"
	upgrade = [0, 0]
	head = get_node("tSpace/Body/Head")
	bulletAnchor = $tSpace/Body/bulletAnchor
	
	aoeRad = GameData.bulletData["missle"]["aoe"]
	angle = GameData.towerData[tower]["angle"]
	dmg = GameData.towerData[tower]["dmg"]
	attackSpeed = GameData.towerData[tower]["as"]
	range = GameData.towerData[tower]["range"]
	bSpeed = GameData.bulletData["missle"]["speed"]
	missle = $tSpace/Body/bulletAnchor/rocket
	missle.setAOE(aoeRad)

func turn():
	head.look_at(enemy.position)
	if !fireCD:
		bulletAnchor.rotation = head.rotation
	if !fireCD:
			fire()


func fire():
	fireCD = true
	rocketStart(missle)
	await(get_tree().create_timer(attackSpeed - 0.2)).timeout
	missle = newMissle.instantiate()
	missle.setAOE(aoeRad)
	missle.position = Vector2(10, 0)
	bulletAnchor.rotation = head.rotation
	bulletAnchor.add_child(missle)
	await(get_tree().create_timer(0.2)).timeout
	bulletAnchor.rotation = head.rotation
	fireCD = false

func rocketStart(body):
	body.dmg = dmg
	body.start = true
	body.speed = bSpeed
	body.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))


func specialUpgrade(tier, path):
	match path:
		1: match tier:
			3:
				pass
			4: 
				var upgraded = load("res://Scenes/Towers/rocket/rocket[01].tscn").instantiate()
				upgraded.passParams(dmg, range, attackSpeed, bSpeed, angle, upgrade, rotation, price, rangeNode.visibleEnemies, aoeRad)
				upgraded.position = position
				upgraded.ifDraw = true
				upgraded.showPlacementArea = true
				emit_signal("superUpgrade", upgraded)
				emit_signal("changeNode", upgraded)
				get_parent().add_child(upgraded)
				queue_free()
		2: match tier:
			3:
				newMissle = load("res://Scenes/Towers/Bullets/fatrocket.tscn")
				if missle != null:
					missle.queue_free()
					missle = newMissle.instantiate()
					missle.position = missle.position + Vector2(10, -0.3)
					missle.show_behind_parent = true
					missle.setAOE(aoeRad)
					head.add_child(missle)
				
			4: pass
#passParams(nDmg, nRange, nAttackSpeed, nBS, nAngle, nUpgrades, nRotation, nAOE = 0, nFireLoc1 = null, nFireLoc2 = null)
