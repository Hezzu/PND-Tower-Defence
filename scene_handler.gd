extends Node
var mainMenu = preload("res://Scenes/UIScenes/main_menu.tscn")
var gameScene = preload("res://Scenes/MainScenes/game.tscn")
var gameOver = preload("res://Scenes/UIScenes/gameOver.tscn")
var upgrades = preload("res://Scenes/UIScenes/GameUpgrades.tscn")
var ufTotal = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu/MarginContainer/Buttons/Start.connect("pressed", Callable(self, "on_new_game_flag"))
	$MainMenu/MarginContainer/Buttons/Exit.connect("pressed", Callable(self, "on_exit_game_flag"))
	$MainMenu/MarginContainer/Buttons/Upgrades.connect("pressed", Callable(self, "on_upgrades_pressed"))
	$MainMenu/MarginContainer/TopBar/UF.text = str(ufTotal)

func on_new_game_flag():
	get_node("MainMenu").queue_free()
	var nGameScene = gameScene.instantiate()
	add_child(nGameScene)
	nGameScene.connect("gameOver", Callable(self, "on_game_over"))
	
func on_exit_game_flag():
	get_tree().quit()

func on_upgrades_pressed():
	var nGameUpgrades = upgrades.instantiate()
	add_child(nGameUpgrades)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_over(result, cWave, hp, time, timeRaw, uf):
	var nMainMenu = mainMenu.instantiate()
	add_child(nMainMenu)
	$MainMenu/MarginContainer/Buttons/Start.connect("pressed", Callable(self, "on_new_game_flag"))
	$MainMenu/MarginContainer/Buttons/Exit.connect("pressed", Callable(self, "on_exit_game_flag"))
	$MainMenu/MarginContainer/Buttons/Upgrades.connect("pressed", Callable(self, "on_upgrades_pressed"))
	
	var nGameOver = gameOver.instantiate()
	add_child(nGameOver)
	if result:
		nGameOver.get_node("VBoxContainer/LabelPane/GMPane").text = "You Win"
	else:
		nGameOver.get_node("VBoxContainer/LabelPane/GMPane").text = "Game Over"
	nGameOver.get_node("VBoxContainer/Label").text = "Wave: " + str(cWave) + "\nBase Health: " + str(hp) + "\nTime: " + time + "\nUF Gained: " + str(calcUF(cWave, hp, timeRaw, uf))
	$Game.queue_free()

func calcUF(wave, hp, time, baseUF):
	var seconds = time / 60
	var outcome = round(baseUF + (((wave * 1000) / seconds) * (hp / 10)))
	ufTotal += outcome
	$MainMenu/MarginContainer/TopBar/UF.text = str(ufTotal)
	return outcome
