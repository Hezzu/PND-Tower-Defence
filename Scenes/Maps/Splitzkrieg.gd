extends Node2D
@onready var pathsArray = [$Path0, $Path1]

func getPaths():
	return pathsArray.size()
func getTM():
	return $Ground
