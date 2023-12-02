extends "res://Scenes/Towers/TowerMgr.gd"

var newMissle = preload("res://Scenes/Towers/Bullets/rocket.tscn")

var bulletAnchor2
var fireCD2 = false

func _ready():
	tower = "rocket"
	built = true
	head = $tSpace/Body/Head
	missle = $tSpace/Body/bulletAnchor/rocket
	missle2 = $tSpace/Body/bulletAnchor2/rocket1
	bulletAnchor = $tSpace/Body/bulletAnchor
	bulletAnchor2 = $tSpace/Body/bulletAnchor2
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
					bulletAnchor.rotation = head.rotation
					fire1()
					await(get_tree().create_timer(attackSpeed / 2)).timeout
					x = 2
			2:
				if !fireCD2:
					bulletAnchor2.rotation = head.rotation
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
	missle.setAOE(aoeRad)
	missle.position = Vector2(10, 7)
	bulletAnchor.rotation = head.rotation
	bulletAnchor.add_child(missle)
	await(get_tree().create_timer(0.2)).timeout
	bulletAnchor.rotation = head.rotation
	fireCD = false
func fire2():
	fireCD2 = true
	rocketStart(missle2)
	await(get_tree().create_timer(attackSpeed - 0.2)).timeout
	missle2 = newMissle.instantiate()
	missle2.setAOE(aoeRad)
	missle2.position = Vector2(10, -7)
	bulletAnchor2.rotation = head.rotation
	bulletAnchor2.add_child(missle2)
	await(get_tree().create_timer(0.2)).timeout
	bulletAnchor2.rotation = head.rotation
	fireCD2 = false

func rocketStart(body):
	body.dmg = dmg
	body.start = true
	body.speed = bSpeed
	body.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
#passParams(nDmg, nRange, nAttackSpeed, nAOE, nBS, nAngle, nUpgrades)

