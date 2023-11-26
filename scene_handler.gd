extends Node
var mainMenu = preload("res://Scenes/UIScenes/main_menu.tscn")
var gameScene = preload("res://Scenes/MainScenes/game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MainMenu/MarginCont/VBoxMM/New Game").connect("pressed", Callable(self, "on_new_game_flag"))
	get_node("MainMenu/MarginCont/VBoxMM/Quit").connect("pressed", Callable(self, "on_exit_game_flag"))

func on_new_game_flag():
	get_node("MainMenu").queue_free()
	var nGameScene = gameScene.instantiate()
	add_child(nGameScene)
	nGameScene.connect("gameOver", Callable(self, "on_game_over"))
	
func on_exit_game_flag():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_over(result):
	mainMenu = mainMenu.instantiate()
	get_node("MainMenu/MarginCont/VBoxMM/New Game").connect("pressed", Callable(self, "on_new_game_flag"))
	get_node("MainMenu/MarginCont/VBoxMM/Quit").connect("pressed", Callable(self, "on_exit_game_flag"))
	add_child(mainMenu)
	$Game.queue_free()
	if result:
		pass
		#Add post game screen
