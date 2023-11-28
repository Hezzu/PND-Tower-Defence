extends PathFollow2D

signal baseDamage(damage)
var unit
var speed
var hp
var destroyed = false
@onready var hpbar = get_node("healthbar")
@onready var gameNode = self.get_parent().get_parent().get_parent()


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

func on_hit(damage):
	hp -= damage
	hpbar.value = hp
	if hp <= 0:
		on_destroy()
func on_destroy():
	if !destroyed:
		destroyed = true
		gameNode.money += GameData.enemyData[unit]["KillGold"]
		gameNode.updateMoney()
		gameNode.enemiesCount -= 1
		queue_free()
