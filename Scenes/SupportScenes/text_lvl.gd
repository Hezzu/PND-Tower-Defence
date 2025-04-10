extends Node2D
@onready var pathsArray = [$Path0, $Path1]
var tank = preload("res://Scenes/SupportScenes/test_tank.tscn")
var cWave = 24
var waveEnd = false
var waveChecker = false
var enemiesCount = 0
var uMenu
var diff = "Easy"
var money = 99999999999999

func _ready():
	Engine.time_scale = 2.5
	deploy($Towers/Turret, 4, 1)
	deploy($Towers/Turret2, 3, 2)
	deploy($Towers/Turret3, 2, 4)
	deploy($Towers/Turret4, 2, 3)
	deploy($Towers/Rocket, 2, 4)
	deploy($Towers/Rocket2, 4, 2)
	deploy($Towers/RoadBlock, 2, 4)
	deploy($Towers/RoadBlock2, 4, 2)
	wave_start()

func deploy(unit, p1, p2):
	for i in range(0, p1):
		_on_upgrade_pressed(unit, 1)
	for i in range(0, p2):
		_on_upgrade_pressed(unit, 2)
	unit.built = true

func getPaths():
	return pathsArray.size()
func getTM():
	return $Ground

func wave_start():
		var waveData = waveState()
		waveEnd = false
		waveChecker = false
		await(get_tree().create_timer(2.0)).timeout
		spawnEnemy(waveData)

func waveState():
	cWave += 1
	var waveData = GameData.waveData[cWave]
	return waveData

func spawnEnemy(waveData):
	for i in waveData:
		for n in i[0]:
			var spawned = tank.instantiate()
			spawned.fillInfo(i[1])
			get_node("Path" + str(enemiesCount % getPaths())).add_child(spawned, true)
			spawned.baseSpeed = spawned.speed * 2
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
	if cWave >= GameData.waveData.size():
		cWave = 24
		wave_start()
	else:
		waveEnd = true
		wave_start()

func makeUpgrades(tower, path, tier, type):
	if GameData.upgradeData[tower.tower][path][tier].has(type):
		return GameData.upgradeData[tower.tower][path][tier][type]
	else:
		return 0

func _on_upgrade_pressed(tower, path):
				var tempStats = []
				for i in tower.stats:
					tempStats.append(makeUpgrades(tower, "p" + str(path), tower.upgrade[path - 1] + 1, i))
				tower.specialUpgrade(tower.upgrade[path - 1] + 1, path)
				tower.upgradeUnit(tempStats[0], tempStats[1], tempStats[2], tempStats[3], tempStats[4], tempStats[5], tempStats[6], tempStats[7], tempStats[8])
				tower.upgrade[path - 1] += 1
