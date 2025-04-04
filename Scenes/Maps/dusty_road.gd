extends Node2D
@onready var pathsArray = [$Path0]

func getPaths():
	return pathsArray.size()
func getTM():
	return $Area

func getPathEnemies():
	var tempArray = []
	for i in pathsArray:
		tempArray.append_array(i.get_children())
	return tempArray
