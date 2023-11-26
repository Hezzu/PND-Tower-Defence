extends Area2D
var visibleEnemies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	visibleEnemies.append(body.get_parent())


func _on_body_exited(body):
	visibleEnemies.erase(body.get_parent())

func refRange(shape, range):
	shape.radius = range
	$Range.set_shape(shape)
