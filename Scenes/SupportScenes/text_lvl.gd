extends Node2D
@onready var pathsArray = [$Path0, $Path1]
var cWave = 24
var waveEnd = false
var waveChecker = false
var enemiesCount = 0
var uMenu

func _ready():
	uMenu = $UpgradeMenu
	Engine.time_scale = 2.5
	deploy($Towers/Turret, 4, 1)
	deploy($Towers/Turret2, 3, 2)
	deploy($Towers/Turret3, 2, 4)
	deploy($Towers/Turret4, 3, 2)
	deploy($Towers/Rocket, 2, 4)
	deploy($Towers/Rocket2, 4, 2)
	deploy($Towers/RoadBlock, 2, 4)
	deploy($Towers/RoadBlock2, 4, 2)
	wave_start()

func deploy(unit, p1, p2):
	uMenu.tower = unit
	for i in range(0, p1):
		uMenu._on_upgrade_p1_pressed()
	for i in range(0, p2):
		uMenu._on_upgrade_p2_pressed()
	unit.built = true

func getPaths():
	return pathsArray.size()
func getTM():
	return $Ground

func wave_start():
		var waveData = waveState()
		waveEnd = false
		waveChecker = false
		await(get_tree().create_timer(0.2)).timeout
		spawnEnemy(waveData)

func waveState():
	cWave += 1
	var waveData = GameData.previewData[cWave]
	return waveData

func spawnEnemy(waveData):
	for i in waveData:
		for n in i[0]:
			var spawned = load("res://Scenes/SupportScenes/test_" + i[1] + ".tscn").instantiate()
			get_node("Path" + str(enemiesCount % getPaths())).add_child(spawned, true)
			spawned.baseSpeed = spawned.speed
			spawned.speed = spawned.baseSpeed
			spawned.maxHp = spawned.hp * 2
			spawned.hp = spawned.maxHp
			spawned.hpBarSet()
			enemiesCount += 1
			await(get_tree().create_timer(i[2])).timeout
	waveChecker = true
	await(get_tree().create_timer(2.0)).timeout
	endWave()

func endWave():
	if cWave >= GameData.previewData.size():
		cWave = 24
		wave_start()
	else:
		waveEnd = true
		wave_start()
