extends CharacterBody2D

var type
var dmg
var speed
var target
var aoe
var timerCheck = false

func _physics_process(delta):
	var collision = move_and_collide(target * speed * delta)
	if collision:
		collision.get_collider().get_parent().on_hit(dmg)
		queue_free()
	if !timerCheck:
		destroy()

func destroy():
	timerCheck = true
	await(get_tree().create_timer(10.0)).timeout
	queue_free()
