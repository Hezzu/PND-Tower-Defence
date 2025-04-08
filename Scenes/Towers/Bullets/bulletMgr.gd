extends CharacterBody2D

var type
var dmg
var speed
var target
var aoe
var timerCheck = false
var dmgMod = 1
var hitSound
var hitEffect
var end = false

func _physics_process(delta):
	var collision
	if !end:
		collision = move_and_collide(target * speed * delta)
	if collision:
		collision.get_collider().get_parent().on_hit(dmg * dmgMod)
		hitSound.play()
		hitEffect.play()
		end = true
	if !timerCheck:
		destroy()

func destroy():
	timerCheck = true
	await(get_tree().create_timer(10.0)).timeout
	queue_free()

func animfinish():
	queue_free()
