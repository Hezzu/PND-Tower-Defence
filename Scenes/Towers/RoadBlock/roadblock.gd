extends "res://Scenes/Towers/TowerMgr.gd"

var visibleEnemies = []

func _ready():
	tower = "roadblock"
	upgrade = [0, 0]
	head = $Body
	rangeNode = $tSpace
	targeting = ["All"]
	percDmg = GameData.towerData[tower]["pDmg"]
	slow = GameData.towerData[tower]["slow"]
	time = GameData.towerData[tower]["time"]
	dmg = GameData.towerData[tower]["dmg"]
	
func _physics_process(delta):
	if visibleEnemies.size() != 0 and built:
		for i in visibleEnemies:
			if !i.slowed:
				i.slowed = true
				i.on_hit(dmg + (i.hp * percDmg))
				i.slow(time, slow)
	
	
func _on_body_entered(body):
	visibleEnemies.append(body.get_parent())


func _on_body_exited(body):
	visibleEnemies.erase(body.get_parent())

func specialUpgrade(tier, path):
	match path:
		1: head.texture.region = Rect2(upgrade[1]*64, tier*64, 64, 64)
		2: head.texture.region = Rect2(tier*64, upgrade[0]*64, 64, 64)

func _draw():
	var color = Color(170.0, 170.0, 170.0, 0.3)
	if showPlacementArea:
		draw_rect(rangeNode.shape.get_rect(), Color("0079a21a"))
