extends "res://Scenes/Towers/TowerMgr.gd"

var visibleEnemies = []
var hitEnemies = []

func _ready():
	tower = "roadblock"
	upgrade = [0, 0]
	head = $Body
	rangeNode = $tSpace
	targeting = ["All"]
	price = GameData.shopData[tower]["price"]
	stats["Percentage Damage"] = GameData.towerData[tower]["pDmg"]
	stats["Slow Amount"] = GameData.towerData[tower]["slow"]
	stats["Slow Time"] = GameData.towerData[tower]["time"]
	stats["Damage"] = GameData.towerData[tower]["dmg"]
	
func _physics_process(_delta):
	if visibleEnemies.size() != 0 and built:
		for i in visibleEnemies:
			if hitEnemies.find(i) != -1:
				var tempSpeed
				if !i.slowed:
					tempSpeed = round(i.speed * stats["Slow Amount"])
				else:
					tempSpeed = i.speed * (stats["Slow Amount"] / 2)
				i.slow(stats["Slow Time"], tempSpeed)
				i.slowed = true
				i.on_hit(stats["Damage"] + (i.hp * stats["Percentage Damage"]))
				hitEnemies.erase(i)
				await (get_tree().create_timer(stats["Slow Time"])).timeout
				if  i != null:
					if !i.is_queued_for_deletion():
						i.speed += tempSpeed
						if i.infoOpened:
							i.infoBar.fillInfo(i)
				
	
	
func _on_body_entered(body):
	visibleEnemies.append(body.get_parent())
	hitEnemies.append(body.get_parent())


func _on_body_exited(body):
	visibleEnemies.erase(body.get_parent())

func specialUpgrade(tier, path):
	match path:
		1: head.texture.region = Rect2(upgrade[1]*256, tier*256, 256, 256)
		2: head.texture.region = Rect2(tier*256, upgrade[0]*256, 256, 256)

func _draw():
	if showPlacementArea:
		draw_rect(rangeNode.shape.get_rect(), Color("0079a21a"))
