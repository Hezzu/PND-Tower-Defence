extends CharacterBody2D

var type
var dmg
var speed
var target
var aoe

func _physics_process(delta):
	var collision = move_and_collide(target * speed * delta)
	if collision:
		collision.get_collider().get_parent().on_hit(dmg)
		queue_free()
