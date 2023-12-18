extends MarginContainer
var unit
var hp
var armor
var speed
var baseDmg

func _ready():
	unit = $MarginContainer/VBoxContainer/Unit
	hp = $MarginContainer/VBoxContainer/Hp
	armor = $MarginContainer/VBoxContainer/Armor
	speed = $MarginContainer/VBoxContainer/Speed
	baseDmg = $MarginContainer/VBoxContainer/BaseDmg

func fillInfo(enemy):
	unit.text = enemy.unit
	hp.text = "HP: " + str(ceil(enemy.hp)) + "/" + str(ceil(enemy.maxHp))
	if GameData.enemyData[enemy.unit].has("armor"):
		armor.visible = true
		armor.text = "Armor: " + str(1.0 - enemy.armor) + "%"
	speed.text = "Speed: " + str(round(enemy.speed))
	baseDmg.text = "Damge to Base: " + str(GameData.enemyData[enemy.unit]["base_dmg"])
