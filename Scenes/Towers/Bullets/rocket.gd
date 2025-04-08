extends "res://Scenes/Towers/Bullets/bulletMgr.gd"

var aoeSMod = 1
var aoeMod = 0.5
var circle = CircleShape2D.new()
@onready var aoeNode = $aoeArea
var start = false
var body

var sEnd = false
var aEnd = false

func _ready():
	type = "missle"
	body = $Sprite2D
	hitSound = $hitSound
	hitEffect = $aoeArea/Explosion
	speed = GameData.bulletData[type]["speed"]
	aoe = GameData.bulletData[type]["aoe"]
	aoeMod = GameData.bulletData[type]["aoeMod"]
	dmgMod = GameData.bulletData[type]["dmgInc"]
	aoeSMod = GameData.bulletData[type]["aoeSMod"]
func setAOE(aoe):
	circle.radius = aoe * aoeSMod
	$aoeArea/aoe.set_shape(circle)
	hitEffect.scale = Vector2(float((aoe * aoeSMod) / 10), float((aoe * aoeSMod) / 10))

func setHitSound(sound):
	hitSound.stream = sound

func _physics_process(delta):
	if start:
		var collision = move_and_collide(target * speed * delta)
		if collision:
			collision.get_collider().get_parent().on_hit(dmg * dmgMod)
			aoeNode.enemiesInRange.erase(collision.get_collider().get_parent())
			for i in aoeNode.enemiesInRange.size():
				aoeNode.enemiesInRange[i].on_hit((dmg * dmgMod) * aoeMod)
			body.queue_free()
			start = false
			hitSound.play()
			hitEffect.play()

func soundFinish():
	sEnd = true
	missileEnd()
func animFinish():
	aEnd = true
	missileEnd()
func missileEnd():
	if sEnd and aEnd:
		queue_free()
