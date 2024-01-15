extends Node2D

signal gameOver(resultBool)

var dragging = false
var diff = "Easy"
@onready var timeBox = $UI/Hud/WaveInfo/TimeBox
var nMap
var map
var roadNode
@onready var uinode = $UI
@onready var hudnode = $UI/Hud
@onready var moneyNode = $UI/Hud/InfoBoxMargin/InfoBox/Cash/Money
@onready var playBtn = $UI/Hud/GameFlowMargin/GameFlow/snfBtn
@onready var shopBtn = $UI/Hud/GameFlowMargin/GameFlow/snhBtn
@onready var hpbar = $UI/Hud/InfoBoxMargin/InfoBox/HPBar/Label
@onready var waveCounter = $UI/Hud/WaveInfo/WaveBox/Wave
@onready var shop = $UI/Hud/shop
@onready var PauseBtn = $UI/Hud/GameFlowMargin/GameFlow/PauseBtn
@onready var pauseMenu = $UI/Hud/PauseMenu
@onready var camera = $Camera2D
@onready var waveSkipBox = $UI/Hud/WaveSkip
var upgradeWin

var UF = 0.0
@export var money = 450
@export var interestRate = 0.05
@export var flatCashBonus = 130
@export var waveCashMulti = 10
@export var waveSpeedMulti = 0.05
@export var waveHpMulti = 0.02


var baseHealth = 100
var shopOpen = false
var gameSpeed = 1.0
var max_speed = 2.0
var texturePlay = preload("res://Assets/Icons/right.png")
var textureFF = preload("res://Assets/Icons/fastForward.png")
var textureNext = preload("res://Assets/Icons/next.png")
var upgradeMenu = preload("res://Scenes/UIScenes/upgrade_menuRework.tscn")
var enemyInfo = preload("res://Scenes/SupportScenes/enemy_info.tscn")
var tank = preload("res://Scenes/Enemies/tank.tscn")

#Wave Managers
var waveEnd = false
var waveChecker = false
var waveSkipped = false

var maxWaveHp = 0
var waveHp = 0
var infoOpen = false
var lastSelected
var upgradeWindowOpen = false
var tween
var place_rotation = 0
var build_mode = false
var placement_valid = false
var place_loc
var build_type
var cWave = 0
var enemiesCount = 0

func _ready():
	Engine.time_scale = 1.0
	map = load("res://Scenes/Maps/"+ nMap + ".tscn").instantiate()
	add_child(map)
	move_child(map, 0)
	roadNode = map.get_node("TowerExclusione")
	var tilemap = map.getTM()
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var mapSize = (mapRect.size - Vector2i(1, 1)) * tileSize
	camera.limit_bottom = mapSize.y
	camera.limit_right = mapSize.x
	camera.lr = mapSize.x
	camera.lb = mapSize.y
#	money = round(GameData.gameData["StartMoney"] * GameData.diffData[diff]["moneyMod"])
	money = 99999999999
	waveCashMulti = GameData.gameData["CashPerWave"]
	max_speed = GameData.gameData["MaxSpeed"]
	baseHealth = GameData.diffData[diff]["baseHealth"]
	hpbar.text = str(baseHealth)
	waveSpeedMulti = GameData.diffData[diff]["waveSpeedMod"]
	waveHpMulti = GameData.diffData[diff]["waveHpMod"]
	updateMoney()
	for i in get_tree().get_nodes_in_group("buildBtn"):
		i.connect("pressed", Callable(self, "init_build_mode").bind(i.name))
	get_node("UI/Hud/PauseMenu/VBoxContainer/MarginContainer/HBoxContainer/Resume").connect("pressed", Callable(self, "on_resume_press"))
	get_node("UI/Hud/PauseMenu/VBoxContainer/MarginContainer/HBoxContainer/Quit").connect("pressed", Callable(self, "on_quit_press"))
	
func _process(_delta):
	if build_mode:
		update_tower_preview()
	if enemiesCount == 0 and waveChecker and !waveEnd and cWave != 0:
		maxWaveHp = 0
		endWave()
	if cWave < GameData.diffData[diff]["waves"] and waveHp <= maxWaveHp * 0.3 and waveChecker:
		waveSkipBox.visible = true


func _unhandled_input(event):
	if event.is_action_released("build") and build_mode:
		verify_place()
	if event.is_action_released("cancel") and build_mode:
		end_build_mode()
	
	
	if event.is_action_released("tower_rotate") and build_mode:
		rotate_tower()
	if event.is_action("rotateSmoothDown") and build_mode:
		rotateSmoothRight()
	if event.is_action("rotateSmoothUp") and build_mode:
		rotateSmoothLeft()
	if event.is_action_released("build") and upgradeWindowOpen and !build_mode:
		disable_upgradePrompt(lastSelected)
	
	
	if event.is_action_released("waveStart"):
		playBtn.emit_signal("pressed")
	if event.is_action_released("quickShop"):
		openShop()


	if event.is_action_released("tower1"):
		if build_mode:
			end_build_mode()
		init_build_mode("turret")
	if event.is_action_released("tower2"):
		if build_mode:
			end_build_mode()
		init_build_mode("rocket")
	if event.is_action_released("tower3"):
		if build_mode:
			end_build_mode()
		init_build_mode("roadblock")
#Controls

# Waves
func wave_start():
	if cWave <= GameData.diffData[diff]["waves"]:
		var waveData = waveState()
		waveEnd = false
		waveChecker = false
		await(get_tree().create_timer(0.2)).timeout
		hudUpdate()
		spawnEnemy(waveData)

func waveState():
	cWave += 1
	var waveData = GameData.waveData[cWave]
	return waveData

func spawnEnemy(waveData):
	for i in waveData:
		for n in i[0]:
			var spawned = tank.instantiate()
			spawned.connect("baseDamage", Callable(self, "on_base_damage"))
			spawned.connect("infoPrompt", Callable(self, "on_info_prompt"))
			spawned.fillInfo(i[1])
			map.get_node("Path" + str(enemiesCount % map.getPaths())).add_child(spawned, true)
			spawned.baseSpeed = spawned.speed * waveSpeedMulti
			spawned.speed = spawned.baseSpeed
			spawned.maxHp = spawned.hp * waveHpMulti
			spawned.hp = spawned.maxHp
			maxWaveHp += spawned.hp
			waveHp += spawned.hp
			spawned.hpBarSet()
			enemiesCount += 1
			await(get_tree().create_timer(i[2])).timeout
	waveChecker = true

func endWave():
	if cWave >= GameData.diffData[diff]["waves"]:
		emit_signal("gameOver", true, cWave, baseHealth, timeBox.formatTime(timeBox.time), timeBox.time, UF, GameData.diffData[diff]["ufMulti"])
	else:
		waveEnd = true
		money += round((flatCashBonus + cWave * waveCashMulti + (interestRate * money)) * GameData.diffData[diff]["moneyMod"])
		updateMoney()
		if gameSpeed == max_speed or waveSkipped:
			wave_start()
			waveSkipped = false
			waveSkipBox.visible = false
		else:
			gameSpeed = 1.0
			Engine.time_scale = gameSpeed
			playBtn.icon = textureNext
			waveSkipBox.visible = false

func on_upgradePrompt(object):
	if get_node_or_null("UI/Hud/UpgradeMenu") == null and !build_mode:
		var upgradeWindow
		upgradeWindow = upgradeMenu.instantiate()
		if Vector2(object.position.x, object.position.y) > get_viewport().get_visible_rect().size / 2:
			upgradeWindow.alignment = 0
		else:
			upgradeWindow.alignment = 2
		hudnode.add_child(upgradeWindow)
		upgradeWin = $UI/Hud/UpgradeMenu
		object.ifDraw = true
		object.showPlacementArea = true
		upgradeWindow.connect("deductMoney", Callable(self, "deductMoney"))
		upgradeWindow.connect("unitSold", Callable(self, "unitSold"))
		upgradeWindow.connect("moneyCheck", Callable(self, "moneyCheck"))
		upgradeWindow.tower = object
		upgradeWindow.diff = diff
		upgradeWindow.fillInfo()
		lastSelected = object
		
		
		await(get_tree().create_timer(0.1)).timeout
		upgradeWindowOpen = true

func nodeChange(newNode):
	lastSelected = newNode
	upgradeWin.selectedTower = newNode

func deductMoney(amount):
	money -= amount
	updateMoney()
	upgradeWin.money = money

func moneyCheck():
	upgradeWin.money = money

func unitSold(refund):
	disable_upgradePrompt(lastSelected)
	lastSelected.queue_free()
	money += refund
	updateMoney()
func disable_upgradePrompt(tower):
	if tower != null:
		tower.ifDraw = false
		tower.showPlacementArea = false
	upgradeWin.queue_free()
	upgradeWindowOpen = false
	
func on_info_prompt(object, state):
	if state and !infoOpen:
		if object.get_node_or_null("EnemyInfo") == null:
			infoOpen = true
			var nInfo = enemyInfo.instantiate()
			object.add_child(nInfo)
			nInfo.top_level = true
			object.infoBar = object.get_node("EnemyInfo")
			object.infoOpened = true
			nInfo.fillInfo(object)
	else:
		infoOpen = false
		object.infoOpened = false
		if object.get_node_or_null("EnemyInfo") != null:
			object.get_node("EnemyInfo").queue_free()


func on_base_damage(bdmg):
	baseHealth -= bdmg
	hpbar.text = str(baseHealth)
#	hpbar.value = baseHealth
#	tween = hpbar.create_tween()
#	tween.tween_property(hpbar, "value", baseHealth, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	if baseHealth < 1:
		emit_signal("gameOver", false, cWave, 0, timeBox.formatTime(timeBox.time), timeBox.time, UF, GameData.diffData[diff]["ufMulti"])
# Controls
func openShop():
	if !build_mode:
		shop.visible = !shop.visible
		shopOpen = !shopOpen
func gameFlow():
	if !build_mode:
		if cWave == 0:
			wave_start()
			timeBox.startTime = true
		elif waveEnd:
			wave_start()
			playBtn.icon = texturePlay
		elif gameSpeed == 1.0:
			Engine.time_scale = max_speed
			gameSpeed = max_speed
			playBtn.icon = textureFF
		else:
			Engine.time_scale = 1.0
			gameSpeed = 1.0
			playBtn.icon = texturePlay
			
func updateMoney():
	moneyNode.text = str(money)
func hudUpdate():
	waveCounter.text = str(cWave) + "/" + str(GameData.diffData[diff]["waves"])
# Building towers
func init_build_mode(tower):
	if shopOpen:
		shop.visible = false
	if upgradeWindowOpen:
		disable_upgradePrompt(lastSelected)
	if build_mode:
		end_build_mode()
	build_type = tower
	build_mode = true
	uinode.set_tower_preview(build_type, get_local_mouse_position())

func update_tower_preview():
	var mouse_pos = get_global_mouse_position()
	var pos = roadNode.local_to_map(mouse_pos)
	match GameData.towerData[build_type]["placement"]:
		"ground": 
					if roadNode.get_cell_source_id(0,pos) == -1 and !get_node("Tower Preview/TowerDrag").has_overlapping_areas():
						uinode.update_tower_preview(mouse_pos, "a7b500a5")
						placement_valid = true
						place_loc = mouse_pos
					else:
						uinode.update_tower_preview(mouse_pos, "eb000ecb")
						placement_valid = false
		"road": 
					if roadNode.get_cell_source_id(0,pos) != -1 and !get_node("Tower Preview/TowerDrag").has_overlapping_areas():
						uinode.update_tower_preview(mouse_pos, "a7b500a5")
						placement_valid = true
						place_loc = mouse_pos
					else:
						uinode.update_tower_preview(mouse_pos, "eb000ecb")
						placement_valid = false

func verify_place():
	if placement_valid == true:
		if money >= round(GameData.shopData[build_type]["price"] * GameData.diffData[diff]["priceMod"]):
			var newTower = load("res://Scenes/Towers/" + build_type + "/" + build_type + ".tscn").instantiate()
			newTower.set_rotation_degrees(place_rotation)
			newTower.position = place_loc
			newTower.stats["Price"] = GameData.shopData[build_type]["price"] * GameData.diffData[diff]["priceMod"]
			newTower.built = true
			newTower.togglePlacementArea()
			newTower.connect("upgradePrompt", Callable(self, "on_upgradePrompt"))
			map.get_node("Towers").add_child(newTower, true)
			money -= GameData.shopData[build_type]["price"] * GameData.diffData[diff]["priceMod"]
			updateMoney()
			end_build_mode()

func end_build_mode():
	if shopOpen:
		shop.visible = true
	build_mode = false
	placement_valid = false
	for i in get_tree().get_nodes_in_group("tower"):
			i.togglePlacementArea()
	place_rotation = 0
	get_node("Tower Preview").free()
func rotate_tower():
	get_node("Tower Preview/TowerDrag").set_rotation_degrees(get_node("Tower Preview/TowerDrag").get_rotation_degrees() + 45)
	place_rotation += 45
func rotateSmoothLeft():
	get_node("Tower Preview/TowerDrag").set_rotation_degrees(get_node("Tower Preview/TowerDrag").get_rotation_degrees() - 1)
	place_rotation -= 1
func rotateSmoothRight():
		get_node("Tower Preview/TowerDrag").set_rotation_degrees(get_node("Tower Preview/TowerDrag").get_rotation_degrees() + 1)
		place_rotation += 1


func _on_pause_btn_pressed():
	pauseMenu.visible = !pauseMenu.visible
	if Engine.time_scale != 0.0:
		Engine.time_scale = 0.0
	else:
		Engine.time_scale = gameSpeed
func on_resume_press():
	pauseMenu.visible = !pauseMenu.visible
	Engine.time_scale = gameSpeed
func on_quit_press():
	emit_signal("gameOver", false, cWave, 0, timeBox.formatTime(timeBox.time), timeBox.time, UF, GameData.diffData[diff]["ufMulti"])


func _on_wave_skip():
	waveSkipped = true
	endWave()
	waveSkipBox.visible = false


func _on_decline_pressed():
	waveSkipBox.visible = false
