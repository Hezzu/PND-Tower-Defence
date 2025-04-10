extends Node

var cDiffSel
var DiffVis = false
var save_path = "user://newSaveFormat.save"
var mainMenu = preload("res://Scenes/UIScenes/main_menu.tscn")
var gameScene = preload("res://Scenes/MainScenes/game.tscn")
var gameOver = preload("res://Scenes/UIScenes/gameOver.tscn")
var info = preload("res://Scenes/UIScenes/info.tscn")
var diffSel = preload("res://Scenes/UIScenes/diff_select.tscn")
var textGame
var gameUpgrades
var mapSelect
var ufLabel
var debugLabel
var debug = false
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
	mapSelect = $MainMenu/MapSelector
	ufLabel = $MainMenu/MarginContainer/Panel/TopBar/UF
	debugLabel = $MainMenu/MarginContainer/Panel/TopBar/Debug
	gameUpgrades = $MainMenu/ufUpgrades
	textGame = $MainMenu/textLvl
	debugLabel.visible = debug
	$MainMenu/MarginContainer/Buttons/Start.connect("pressed", Callable(self, "on_new_game_flag"))
	$MainMenu/MarginContainer/Buttons/Exit.connect("pressed", Callable(self, "on_exit_game_flag"))
	$MainMenu/MarginContainer/Buttons/Upgrades.connect("pressed", Callable(self, "on_upgrades_pressed"))
	$MainMenu/MarginContainer/Buttons/Info.connect("pressed", Callable(self, "on_info_pressed"))
	$MainMenu/Debug.connect("pressed", Callable(self, "on_debug_pressed"))

func _input(event):
	if event.is_action_released("build") and DiffVis and mapSelect.get_node_or_null("DiffSelect") != null:
		cDiffSel.queue_free()
		DiffVis = false

func selectDiff(map, sDiff):
	get_node("MainMenu").queue_free()
	DiffVis = false
	var nGameScene = gameScene.instantiate()
	nGameScene.nMap = map
	nGameScene.diff = sDiff
	nGameScene.debug = debug
	add_child(nGameScene)
	nGameScene.connect("gameOver", Callable(self, "on_game_over"))

func selectMap(selectedMap):
	if DiffVis:
		cDiffSel.queue_free()
	cDiffSel = diffSel.instantiate()
	cDiffSel.get_node("MarginContainer/VBoxContainer/Map").text = "Map: " + selectedMap
	DiffVis = true
	mapSelect.add_child(cDiffSel)
	for i in get_tree().get_nodes_in_group("diffSel"):
		if GameData.diffData[i.name]["unlocked"]:
			i.disabled = false
		i.pressed.connect(selectDiff.bind(selectedMap, i.name))
	

func on_new_game_flag():
	$MainMenu/MapSelector.visible = true
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()

func on_exit_game_flag():
	save_game()
	get_tree().quit()

func on_upgrades_pressed():
	gameUpgrades.visible = true
	gameUpgrades.get_node("CanvasLayer").visible = true
	gameUpgrades.get_node("upgCam").enabled = true
	gameUpgrades.uf = ufTotal
	gameUpgrades.updateUF()

func on_info_pressed():
	var nInfo = info.instantiate()
	$MainMenu.add_child(nInfo)
	nInfo.z_index = 3

func on_debug_pressed():
	debugLabel.visible = !debugLabel.visible
	debug = !debug

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
		var _save_nodes = get_tree().get_nodes_in_group("Persist")
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
					GameData.gameUpgradesData[i]["bought"] = node_data[i][0]
					GameData.gameUpgradesData[i]["enabled"] = node_data[i][1]
					if node_data[i][1]:
						gameUpgrades.applyUpgs(1, i)
					if node_data[i][2] and !GameData.gameUpgradesData[i]["for"] == null:
						match GameData.gameUpgradesData[i]["for"][0]:
							"tower":
								GameData.towerData[GameData.gameUpgradesData[i]["for"][1]]["unlocked"] = node_data[i][1]
							"diff":
								GameData.diffData[GameData.gameUpgradesData[i]["for"][1]]["unlocked"] = node_data[i][1]
		#ufTotal = 999999
		loaded = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_game_over(result, cWave, hp, hpRatio, time, timeRaw, uf, ufMulti, isdebug):
	var nMainMenu = mainMenu.instantiate()
	add_child(nMainMenu)
	initConnects()
	
	var nGameOver = gameOver.instantiate()
	add_child(nGameOver)
	if isdebug:
		nGameOver.get_node("MarginContainer/VBoxContainer/LabelPane/GMPane").text = "Debug Mode"
		nGameOver.get_node("MarginContainer/VBoxContainer/Label").text = "Debug Mode: No UF Gained"
		updateUF()
	elif result:
		nGameOver.get_node("MarginContainer/VBoxContainer/LabelPane/GMPane").text = "You Win"
		nGameOver.get_node("MarginContainer/VBoxContainer/Label").text = "Wave: " + str(cWave) + "\nBase Health: " + str(hp) + "\nTime: " + time + "\nUF Gained: " + str(calcUF(cWave, hpRatio, timeRaw, uf, ufMulti))
	else:
		nGameOver.get_node("MarginContainer/VBoxContainer/LabelPane/GMPane").text = "Game Over"
		nGameOver.get_node("MarginContainer/VBoxContainer/Label").text = "Wave: " + str(cWave) + "\nBase Health: " + str(hp) + "\nTime: " + time + "\nUF Gained: " + str(calcUF(cWave, hpRatio, timeRaw, uf, ufMulti))
	$Game.queue_free()

func calcUF(wave, hpRatio, time, baseUF, ufMulti):
	if time != 0:
		var outcome
		var seconds = time / 60
		print("BaseUF: " + str(baseUF))
		if hpRatio == 0:
			outcome = baseUF / 100
		else:
			outcome = ((baseUF * ufMulti) / (seconds / 180)) * (hpRatio)
		ufTotal += round(outcome)
		updateUF()
		return round(outcome)
	else:
		updateUF()
		return 0


func save():
	var save_dict = {
		"ufTotal": ufTotal
	}
	return save_dict


func updateUF():
	ufLabel.text = str(round(ufTotal))
