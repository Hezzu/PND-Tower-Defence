extends PathFollow2D

var unit
var baseSpeed
var speed
var hp
var armor = 1
var infoOpened = false
var maxHp
var sprite
var destroyed = false
var slowed = false

@onready var tankCol = $CharacterBody2D/CollisionShape2D
@onready var tankSprite = $CharacterBody2D
@onready var hitEffect = $hitEffect
@onready var hitSound = $hitSound
@onready var hpbar = get_node("healthbar")
@onready var gameNode = get_parent().get_parent()

func fillInfo(sunit):
	unit = GameData.enemyData[sunit]["unit"]
	sprite = $CharacterBody2D/Body
	sprite.self_modulate = GameData.enemyData[sunit]["color"]
	maxHp = GameData.enemyData[sunit]["hp"]
	hp = maxHp
	baseSpeed = GameData.enemyData[sunit]["speed"]
	speed = baseSpeed


func hpBarSet():
	hpbar.set_max(hp)
	hpbar.set_value(hp)

func _physics_process(delta):
	if !destroyed: move(delta)
	if progress_ratio == 1:
		gameNode.enemiesCount -= 1
		queue_free()

func move(delta):
	set_progress(get_progress() + speed * delta)
	hpbar.position = position - Vector2(30, 30)

func on_hit(damage):
	if armor != 1:
		damage = damage * armor
	hp -= damage
	hpbar.value = hp
	if hp <= 0:
		on_destroy()
func slow(time, tslow):
	var tempTime = 0
	if !slowed:
		tempTime = time
		speed = speed - tslow
	else:
		tempTime += time
		speed = speed - (tslow / 2)
	await (get_tree().create_timer(tempTime)).timeout
	if not null:
		slowed = false
func on_destroy():
	if !destroyed:
		destroyed = true
		tankSprite.visible = false
		tankCol.disabled = true
		hitSound.play()
		hitEffect.play()
		await hitEffect.animation_finished
		await hitSound.finished
		gameNode.enemiesCount -= 1
		queue_free()
