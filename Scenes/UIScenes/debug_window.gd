extends PanelContainer

signal enemy_pressed(unit)
signal clear_units()
signal wave_start(wave)

var newTank = preload("res://Scenes/UIScenes/tanks.tscn")

@onready var clearBtn = $Scroll/Margin/Options/WavePane/Wave/WaveEnd/TextureButton
@onready var waveBtn = $Scroll/Margin/Options/WavePane/Wave/WaveSelect/Wave/Button
@onready var waveNumber = $Scroll/Margin/Options/WavePane/Wave/WaveSelect/Wave
var enemyList = GameData.enemyData


func _ready() -> void:
	for i in enemyList:
		match enemyList[i]["type"]:
			"Normal":
				var tempTank = newTank.instantiate()
				tempTank.get_node("VBox/Control/Body").modulate = enemyList[i]["color"]
				tempTank.name = enemyList[i]["unit"]
				tempTank.pressed.connect(on_enemy_pressed.bind(i))
				$Scroll/Margin/Options/Enemies/Normal/ScrollContainer/Enemybox.add_child(tempTank)
				tempTank.get_node("VBox/Unit").text = enemyList[i]["unit"]
			"Miniboss":
				var tempTank = newTank.instantiate()
				tempTank.get_node("VBox/Control/Body").modulate = enemyList[i]["color"]
				tempTank.name = enemyList[i]["unit"]
				tempTank.pressed.connect(on_enemy_pressed.bind(i))
				$Scroll/Margin/Options/Enemies/Miniboss/ScrollContainer/Enemybox.add_child(tempTank)
				tempTank.get_node("VBox/Unit").text = enemyList[i]["unit"]
			"Boss":
				var tempTank = newTank.instantiate()
				tempTank.get_node("VBox/Control/Body").modulate = enemyList[i]["color"]
				tempTank.name = enemyList[i]["unit"]
				tempTank.pressed.connect(on_enemy_pressed.bind(i))
				$Scroll/Margin/Options/Enemies/Boss/ScrollContainer/Enemybox.add_child(tempTank)
				tempTank.get_node("VBox/Unit").text = enemyList[i]["unit"]
	
	clearBtn.pressed.connect(on_clear_pressed)
	waveNumber.text_changed.connect(waveNumberChecker)
	waveBtn.pressed.connect(setWave)

func waveNumberChecker(text):
	waveNumber.text = str(float(waveNumber.text))

func on_enemy_pressed(cUnit):
	enemy_pressed.emit(cUnit)

func on_clear_pressed():
	clear_units.emit()

func setWave():
	if int(waveNumber.text) <= 60:
		wave_start.emit(int(waveNumber.text))
