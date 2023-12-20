extends PathFollow2D

signal infoPrompt(enemy)
signal baseDamage(damage)
var hover = false
var unit
var speed
var hp
var armor = 1
var maxHp
var baseSpeed
var destroyed = false
var slowed = false
var infoBar
var infoOpened = false
@onready var hpbar = get_node("healthbar")
@onready var gameNode = self.get_parent().get_parent().get_parent()

func hpBarSet():
	hpbar.set_max(hp)
	hpbar.set_value(hp)

func _physics_process(delta):
	move(delta)
	if progress_ratio == 1:
		emit_signal("baseDamage", GameData.enemyData[unit]["base_dmg"])
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
	gameNode.money += 
	hp -= damage
	hpbar.value = hp
	if infoOpened:
		infoBar.fillInfo(self)
	if hp <= 0:
		on_destroy()
func slow(time, slow):
	var tempTime = 0
	if !slowed:
		tempTime = time
	else:
		tempTime += time
	speed = speed - slow
	if infoOpened:
			infoBar.fillInfo(self)
	await (get_tree().create_timer(tempTime)).timeout
	if not null:
		slowed = false
func on_destroy():
	if !destroyed:
		destroyed = true
		gameNode.UF += GameData.enemyData[unit]["UFGain"]
		gameNode.updateMoney()
		gameNode.enemiesCount -= 1
		if infoOpened:
			infoOpened = false
			get_node("EnemyInfo").queue_free()
		queue_free()


func _on_character_body_2d_mouse_entered():
	emit_signal("infoPrompt", self, true)


func _on_character_body_2d_mouse_exited():
	emit_signal("infoPrompt", self, false)
