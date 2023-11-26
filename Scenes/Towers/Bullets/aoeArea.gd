extends Area2D

var enemiesInRange = []
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	enemiesInRange.append(body.get_parent())


func _on_body_exited(body):
	enemiesInRange.erase(body.get_parent())


