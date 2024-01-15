extends Camera2D

var lr = 0
var lb = 0
var _target_zoom = 1.0
const MIN_ZOOM = 1.0
const MAX_ZOOM = 2.0
const ZOOM_INCREMENT = 0.1
const ZOOM_RATE = 8.0

func _physics_process(delta):
	zoom = lerp(
		zoom,
		_target_zoom * Vector2.ONE,
		ZOOM_RATE * delta
	)
	set_physics_process(
		not is_equal_approx(zoom.x, _target_zoom)
	)

func zoom_in():
	_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
	set_physics_process(true)
func zoom_out():
	_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			print(str(position) + "/(" + str(lr) + ", " + str(lb) + ")")
#			print(event.relative)
#			print(clamp(event.relative * zoom, Vector2.ZERO, Vector2(lr * zoom.x, lb * zoom.y)))
			position = clamp((position -  event.relative), Vector2.ZERO, Vector2(lr * zoom.x, lb * zoom.y))
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP: 
				zoom_in()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out()
	
	
