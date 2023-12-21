extends "res://Scenes/Towers/TowerMgr.gd"

var visibleEnemies = []
var hitEnemies = []

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
	
func _physics_process(_delta):
	if visibleEnemies.size() != 0 and built:
		for i in visibleEnemies:
			if hitEnemies.find(i) != -1:
				var tempSpeed
				if !i.slowed:
					tempSpeed = i.speed * slow
				else:
					tempSpeed = i.speed * (slow / 2)
				i.slowed = true
				i.slow(time, tempSpeed)
				i.on_hit(dmg + (i.hp * percDmg))
				hitEnemies.erase(i)
				await (get_tree().create_timer(time)).timeout
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
		1: head.texture.region = Rect2(upgrade[1]*64, tier*64, 64, 64)
		2: head.texture.region = Rect2(tier*64, upgrade[0]*64, 64, 64)

func _draw():
	if showPlacementArea:
		draw_rect(rangeNode.shape.get_rect(), Color("0079a21a"))
