extends HBoxContainer

var startTime = false
var time = 0.0
var hr = 0
var min = 0
var sec = 0

func _physics_process(delta):
	if startTime:
		time += delta
		sec = fmod(time, 60)
		min = fmod(time, 3600) / 60
		hr = fmod(time, 216000) / 3600
		$Sec.text = "%02d" % sec
		$Min.text = "%02d:" % min
		$Hour.text = "%02d:" % hr

func formatTime(ttime) -> String:
	return "%02d:" % (fmod(time, 216000) / 3600) + "%02d:" % (fmod(time, 3600) / 60) + "%02d" % fmod(time, 60)
