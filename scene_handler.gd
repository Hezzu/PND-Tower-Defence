extends Node

var save_path = "user://newSaveFormat.save"
var mainMenu = preload("res://Scenes/UIScenes/main_menu.tscn")
var gameScene = preload("res://Scenes/MainScenes/game.tscn")
var gameOver = preload("res://Scenes/UIScenes/gameOver.tscn")
var info = preload("res://Scenes/UIScenes/info.tscn")
var gameUpgrades
var ufLabel
var ufTotal = 0
var loaded = false
# Called when the node enters the scene tree for the first time.
func _ready():
	initConnects()
	if !loaded:
		load_data()
	updateUF()

func initConnects():
	for i in get_tree().get_nodes_in_group("mapSelector"):
		i.connect("pressed", Callable(self, "selectMap").bind(i.name))
	ufLabel = $MainMenu/MarginContainer/Panel/TopBar/UF
	gameUpgrades = $MainMenu/GameUpgrades
	$MainMenu/MarginContainer/Buttons/Start.connect("pressed", Callable(self, "on_new_game_flag"))
	$MainMenu/MarginContainer/Buttons/Exit.connect("pressed", Callable(self, "on_exit_game_flag"))
	$MainMenu/MarginContainer/Buttons/Upgrades.connect("pressed", Callable(self, "on_upgrades_pressed"))
	$MainMenu/MarginContainer/Buttons/Info.connect("pressed", Callable(self, "on_info_pressed"))

func selectMap(selectedMap):
		get_node("MainMenu").queue_free()
		var nGameScene = gameScene.instantiate()
		nGameScene.nMap = selectedMap
		add_child(nGameScene)
		nGameScene.connect("gameOver", Callable(self, "on_game_over"))

func on_new_game_flag():
	$MainMenu/MapSelector.visible = true
	
	
func on_exit_game_flag():
	save_game()
	get_tree().quit()

func on_upgrades_pressed():
	gameUpgrades.visible = true
	gameUpgrades.get_node("Control/CanvasLayer").visible = true
	gameUpgrades.get_node("Control/upgCam").enabled = true
	gameUpgrades.uf = ufTotal
	gameUpgrades.updateUF()

func on_info_pressed():
	var nInfo = info.instantiate()
	$MainMenu.add_child(nInfo)

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
				print("persistent node '%s' is not an instanced scene, skipped" % node.name)
		if !node.has_method("save"):
				print("persistent node '%s' is missing a save() function, skipped" % node.name)
		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		file.store_line(json_string)
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var save_nodes = get_tree().get_nodes_in_group("Persist")
		while file.get_position() < file.get_length():
			var json_string = file.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			var node_data = json.get_data()
			if node_data.has("ufTotal"):
				ufTotal = node_data["ufTotal"]
				updateUF()
			else:
				for i in node_data:
					for j in node_data[i]:
						GameData.gameUpgradesData[i][j.to_int()]["has"] = node_data[i][j]
						if !GameData.gameUpgradesData[i][j.to_int()]["last"]:
							GameData.gameUpgradesData[i][(j.to_int())+1]["previousHas"] = true
						gameUpgrades.fillUpgradeInfo(j.to_int(), i)
		loaded = true
		
#		ufTotal = file.get_var(ufTotal)
#		for i in file.get_var(GameData.gameUpgradesData):
#			if file.get_var(GameData.gameUpgradesData[i.name]["has"]):
#				GameData.gameUpgradesData[i.name]["has"] = file.get_var(GameData.gameUpgradesData[i.name]["has"])
#		GameData.gameUpgradesData = file.get_var(GameData.gameUpgradesData)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_over(result, cWave, hp, time, timeRaw, uf):
	var nMainMenu = mainMenu.instantiate()
	add_child(nMainMenu)
	initConnects()
	
	var nGameOver = gameOver.instantiate()
	add_child(nGameOver)
	if result:
		nGameOver.get_node("VBoxContainer/LabelPane/GMPane").text = "You Win"
	else:
		nGameOver.get_node("VBoxContainer/LabelPane/GMPane").text = "Game Over"
	nGameOver.get_node("VBoxContainer/Label").text = "Wave: " + str(cWave) + "\nBase Health: " + str(hp) + "\nTime: " + time + "\nUF Gained: " + str(calcUF(cWave, hp, timeRaw, uf))
	$Game.queue_free()

func calcUF(wave, hp, time, baseUF):
	if time != 0:
		var seconds = time / 60
		var outcome = round(baseUF + (((wave * 10) / (seconds / 2)) * (hp / 100)))
		ufTotal += outcome
		updateUF()
		return outcome
	else:
		updateUF()
		return 0


func save():
	var save_dict = {
		"ufTotal": ufTotal
	}
	return save_dict


func updateUF():
	ufLabel.text = str(ufTotal)
