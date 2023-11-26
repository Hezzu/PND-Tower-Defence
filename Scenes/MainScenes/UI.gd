extends CanvasLayer

func set_tower_preview(tower, mouse_pos):
	var towerDrag = load("res://Scenes/Towers/" + tower + "/" + tower + ".tscn").instantiate()
	towerDrag.name = "TowerDrag"
	towerDrag.toggleDrawing()
	var control = Control.new()
	control.add_child(towerDrag, true)
	control.position = mouse_pos
	control.name = "Tower Preview"
	add_child(control, true)
	move_child(get_node("Tower Preview"), 0)

	_update_nodes("tower")

func update_tower_preview(pos, color):
	get_node("Tower Preview").position = pos
	if get_node("Tower Preview").modulate != Color(color):
		get_node("Tower Preview").modulate = Color(color)

func _update_nodes(group):
	for i in get_tree().get_nodes_in_group(group):
		i.togglePlacementArea()
