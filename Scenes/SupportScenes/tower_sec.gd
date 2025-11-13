extends VBoxContainer

var towerTex
var towerTex2
var infoLab
var towerPrc
const assetLoc = "res://Assets/Towers/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	towerTex = $TowerImage
	towerTex2 = $TowerImage/TextureRect
	infoLab = $TowerInfo
	towerPrc = $BuyBtn/Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fillInfo(tower):
	var t1 = AtlasTexture.new()
	t1.atlas = assetLoc + GameData.towerData[tower]
	t1.region = Rect2i(0, 64, 64, 64)
	towerTex.atlas = t1
	var t2 = AtlasTexture.new()
	t2.atlas = assetLoc + GameData.towerData[tower]
	t2.region = Rect2i(0, 0, 64, 64)
	towerTex2 = t2
	infoLab = GameData.towerData[tower]["infoLab"]
	towerPrc = GameData.towerData[tower]["uprice"] + " UF"
