extends PathFollow2D

signal infoPrompt(enemy)
signal baseDamage(damage)
var unit
var baseSpeed
var speed
var hp
var armor = 1
var maxHp
var sprite
var destroyed = false
var slowed = false
var infoBar
var infoOpened = false
var ufGain
var tankSprite
var tankCol

@onready var hitEffect = $hitEffect
@onready var hitSound = $hitSound
@onready var hpbar = get_node("healthbar")
@onready var gameNode = self.get_parent().get_parent().get_parent()
@onready var wMR = gameNode.waveMoneyRatio

func fillInfo(sunit):
	unit = GameData.enemyData[sunit]["unit"]
	tankSprite = $CharacterBody2D
	sprite = $CharacterBody2D/Body
	tankCol = $CharacterBody2D/CollisionShape2D
	sprite.self_modulate = GameData.enemyData[sunit]["color"]
	ufGain = GameData.enemyData[sunit]["UFGain"]
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
		emit_signal("baseDamage", hp)
		gameNode.enemiesCount -= 1
		gameNode.hudUpdate()
		queue_free()

func move(delta):
	set_progress(get_progress() + speed * delta)
	hpbar.position = position - Vector2(30, 30)
	if infoOpened:
		infoBar.position = get_global_mouse_position() - Vector2(infoBar.size.x / 2, -15)

func on_hit(damage):
	if armor != 1:
		damage = damage * armor
	if damage <= hp:
		gameNode.money += snapped(damage / wMR, 0.01)
		gameNode.waveHp -= damage
	else:
		if !hp <= 0:
			gameNode.money += snapped(hp / wMR, 0.01)
			gameNode.waveHp -= hp
	gameNode.updateMoney()
	hp -= damage
	hpbar.value = hp
	if infoOpened:
		infoBar.fillInfo(self)
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
	if infoOpened:
			infoBar.fillInfo(self)
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
		gameNode.UF += ufGain
		gameNode.enemiesCount -= 1
		if infoOpened:
			infoOpened = false
			get_node("EnemyInfo").queue_free()
		queue_free()


func _on_character_body_2d_mouse_entered():
	emit_signal("infoPrompt", self, true)


func _on_character_body_2d_mouse_exited():
	emit_signal("infoPrompt", self, false)
