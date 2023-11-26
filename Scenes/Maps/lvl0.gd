extends Node2D
var paths = 2
@onready var pathsArray = [$Path0, $Path1]

func getPaths():
	return paths
