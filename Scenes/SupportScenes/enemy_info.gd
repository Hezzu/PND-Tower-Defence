extends MarginContainer
var unit
var hp
var armor
var speed
var baseDmg
var hpbar

func _ready():
	unit = $Panel/MarginContainer/VBoxContainer/Unit
	hp = $Panel/MarginContainer/VBoxContainer/ProgressBar/MarginContainer/Hp
	armor = $Panel/MarginContainer/VBoxContainer/Armor
	speed = $Panel/MarginContainer/VBoxContainer/Speed
	hpbar = $Panel/MarginContainer/VBoxContainer/ProgressBar

func fillInfo(enemy):
	if enemy != null: 
		unit.text = enemy.unit
		hp.text = "HP: " + str(ceil(enemy.hp)) + "/" + str(ceil(enemy.maxHp))
		hpbar.max_value = enemy.maxHp
		hpbar.value = enemy.hp
		if enemy.armor < 1:
			armor.visible = true
			armor.text = "Armor: " + str((1.0 - enemy.armor) * 100) + "%"
		speed.text = "Speed: " + str(round(enemy.speed))
