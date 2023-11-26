extends "res://Scenes/Towers/Bullets/bulletMgr.gd"

var circle = CircleShape2D.new()
@onready var aoeNode = $aoeArea
var start = false
func _ready():
	type = "missle"
	speed = GameData.bulletData[type]["speed"]
	aoe = GameData.bulletData[type]["aoe"]
func setAOE(aoe):
	circle.radius = aoe
	$aoeArea/aoe.set_shape(circle)
func _physics_process(delta):
	if start:
		var collision = move_and_collide(target * speed * delta)
		if collision:
			collision.get_collider().get_parent().on_hit(dmg)
			aoeNode.enemiesInRange.erase(collision.get_collider().get_parent())
			for i in aoeNode.enemiesInRange.size():
				aoeNode.enemiesInRange[i].on_hit(dmg/2)
			queue_free()
