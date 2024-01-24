extends Panel
signal left()


func _on_button_pressed():
	emit_signal("left")
	queue_free()
