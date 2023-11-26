extends Area2D

signal changeNode(nNode)
signal upgradePrompt(towerObject)

var ifDraw = false
var showPlacementArea = false
var bullet = preload("res://Scenes/Towers/Bullets/bullet.tscn")

var price
var dmg
var range
var attackSpeed
var angle
var bSpeed
var aoeRad = 0

var fireLoc
var fireLoc2
var upgrade

var missle2
var missle
var circle = CircleShape2D.new()
var bulletSpawn
var fireCD = false
var built = false
var aFrom = 0
var tower
var head
var mouseOver = false

@onready var rangeNode = get_node("RangeArea")
var enemy = null
var enemyProgress
var highestProgress


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if rangeNode.visibleEnemies.size() != 0 and built:
		enemySelection()
		if enemy != null:
			turn()

func _input(event):
	if mouseOver and event.is_action_released("build") and built:
		emit_signal("upgradePrompt", self)
		

func _process(delta):
	queue_redraw()

#tower control
func turn():
	head.look_at(enemy.position)
	if !fireCD:
			fire()
	
func enemySelection():
	enemyProgress = []
	highestProgress = -1
	
	enemy = rangeNode.visibleEnemies.filter(
		func(i): return fmod(rad_to_deg(get_parent().position.angle_to_point(to_local(i.position))),360) <= (angle / 2) and fmod(rad_to_deg(get_parent().position.angle_to_point(to_local(i.position))) ,360) >= -1 * (angle / 2)
	).reduce(func(i, accum): return accum if i.progress < accum.progress else i, null)

func fire():
	fireCD = true
	bulletSpawn = bullet.instantiate()
	bulletSpawn.target = Vector2.UP.rotated(head.rotation + rotation + deg_to_rad(90))
	bulletSpawn.dmg = dmg
	bulletSpawn.speed = bSpeed
	if fireLoc != null:
		fireLoc.add_child(bulletSpawn)
	else:
		add_child(bulletSpawn)
	bulletSpawn.speed = bSpeed
	await(get_tree().create_timer(attackSpeed)).timeout
	fireCD = false
	


func _on_mouse_entered():
	mouseOver = true


func _on_mouse_exited():
	mouseOver = false

func upgradeUnit(damage = 0, nRange = 0, nAttackSpeed = 0, aoe = 0, bulletSpeed = 0, tempAng = 0):
	dmg += damage
	range += nRange
	attackSpeed += nAttackSpeed
	aoeRad += aoe
	bSpeed += bulletSpeed
	rangeNode.refRange(circle, range)
	if aoe > 0 and missle != null:
		missle.setAOE(aoeRad)
	angle += tempAng

# Togglers and Getters for Drawing
func toggleDrawing():
	ifDraw = !ifDraw
func getIfDraw():
	return ifDraw
func togglePlacementArea():
	showPlacementArea = !showPlacementArea
func getPlacementArea():
	return showPlacementArea


func passParams(nDmg, nRange, nAttackSpeed, nBS, nAngle, nUpgrades, nRotation, nPrice, enemyList, nAOE = 0, nFireLoc1 = null, nFireLoc2 = null):
	dmg = nDmg
	range = nRange
	attackSpeed = nAttackSpeed
	aoeRad = nAOE
	bSpeed = nBS
	angle = nAngle
	upgrade = nUpgrades
	rotation = nRotation
	price = nPrice
	$RangeArea.visibleEnemies = enemyList
	if nFireLoc1 != null:
		fireLoc =nFireLoc1
	if nFireLoc2 != null:
		fireLoc2 =nFireLoc2
	$RangeArea.refRange(circle, range)
	if nAOE > 0 and missle != null:
		missle.setAOE(aoeRad)
	if nAOE > 0 and missle2 != null:
		missle2.setAOE(aoeRad)




# Range drawing
func _draw():
	var color = Color(170.0, 170.0, 170.0, 0.3)
	var center = Vector2(0, 0)
	var radius = range
	var angle_from = aFrom - (angle / 2)
	var angle_to = aFrom + (angle / 2)
	if ifDraw:
		draw_circle_arc_poly(center, radius, angle_from, angle_to, color)
	if showPlacementArea:
		draw_circle(center, GameData.towerData[tower]["placement area"], Color("0079a21a"))

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func specialUpgrade(tier, path):
	match path:
		1: match tier:
			3: pass
			4: pass
		2: match tier:
			3: pass
			4: pass
