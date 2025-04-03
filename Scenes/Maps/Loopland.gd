extends Node2D
@onready var pathsArray = [$Path0]

func getPaths():
	return pathsArray.size()
func getTM():
	return $Area
