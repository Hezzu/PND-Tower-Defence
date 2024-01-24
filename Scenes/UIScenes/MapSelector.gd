extends Panel
signal left()


func _on_button_pressed():
	visible = false
	emit_signal("left")
