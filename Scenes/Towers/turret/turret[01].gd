extends "res://Scenes/Towers/TowerMgr.gd"

var bulletSpawn2
var fireCD2 = false

func _ready():
	tower = "turret"
	built = true
	fireLoc = $tSpace/Body/Head/Fire
	fireLoc2 = $tSpace/Body/Head/Fire2
	head = get_node("tSpace/Body/Head")

func _input(event):
	if mouseOver and event.is_action_released("build"):
		emit_signal("upgradePrompt", self)

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

func fire1():
	fireCD = true
	bulletSpawn = bullet.instantiate()
	bulletSpawn.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn.dmg = dmg
	bulletSpawn.speed = bSpeed
	fireLoc.add_child(bulletSpawn)
	bulletSpawn.speed = bSpeed
	await(get_tree().create_timer(attackSpeed)).timeout
	fireCD = false

func fire2():
	fireCD2 = true
	bulletSpawn2 = bullet.instantiate()
	bulletSpawn2.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn2.dmg = dmg
	bulletSpawn2.speed = bSpeed
	fireLoc2.add_child(bulletSpawn2)
	bulletSpawn2.speed = bSpeed
	await(get_tree().create_timer(attackSpeed)).timeout
	fireCD2 = false
