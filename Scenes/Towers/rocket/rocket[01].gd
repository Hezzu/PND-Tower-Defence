extends "res://Scenes/Towers/TowerMgr.gd"

var newMissle = preload("res://Scenes/Towers/Bullets/rocket.tscn")


var fireCD2 = false

func _ready():
	tower = "rocket"
	built = true
	head = $tSpace/Body/Head
	missle = $tSpace/Body/Head/rocket
	missle2 = $tSpace/Body/Head/rocket1
	rangeNode = $RangeArea
	missle.setAOE(aoeRad)
	missle2.setAOE(aoeRad)

func _physics_process(delta):
		if rangeNode.visibleEnemies.size() != 0 and built:
			enemySelection()
			if enemy != null:
				turn()
		else:
			enemy = null
var x = 1
func turn():
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

func _input(event):
	if mouseOver and event.is_action_released("build"):
		emit_signal("upgradePrompt", self)



func fire1():
	fireCD = true
	rocketStart(missle)
	await(get_tree().create_timer((attackSpeed) - 0.2)).timeout
	missle = newMissle.instantiate()
	missle.position = missle.position + Vector2(10, -10)
	missle.show_behind_parent = true
	missle.setAOE(aoeRad)
	head.add_child(missle)
	await(get_tree().create_timer(0.2)).timeout
	fireCD = false
func fire2():
	fireCD2 = true
	rocketStart(missle2)
	await(get_tree().create_timer(attackSpeed - 0.2)).timeout
	missle2 = newMissle.instantiate()
	missle2.position = missle2.position + Vector2(10, 10)
	missle2.show_behind_parent = true
	missle2.setAOE(aoeRad)
	head.add_child(missle2)
	await(get_tree().create_timer(0.2)).timeout
	fireCD2 = false

func rocketStart(body):
	body.dmg = dmg
	body.start = true
	body.speed = bSpeed
	body.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
#passParams(nDmg, nRange, nAttackSpeed, nAOE, nBS, nAngle, nUpgrades)

