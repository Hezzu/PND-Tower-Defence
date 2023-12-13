extends Camera2D

var dragging = false

func _ready():
	limit_right = get_parent().get_rect().size.x
	limit_bottom = get_parent().get_rect().size.y

func _input(event):
	if event is InputEventMouseButton:
			if event.is_pressed():
				dragging = true
			else:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		move_local_x(-event.relative.x)
		move_local_y(-event.relative.y)
	if event.is_action("rotateSmoothDown"):
		if zoom > Vector2(0.8, 0.8):
			zoom -= Vector2(0.1, 0.1)
	if event.is_action("rotateSmoothUp"):
		if zoom < Vector2(2, 2):
			zoom += Vector2(0.1, 0.1)
