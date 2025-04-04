extends PanelContainer
var towerwiki = preload("res://Scenes/UIScenes/tower_info.tscn")
var towerwikiopen = false

var towerList = GameData.shopData
@onready var diff = get_parent().get_parent().get_parent().diff

func _ready():
	for i in towerList:
		get_node("Margin/VBoxContainer/ScrollContainer/BuilderMargin/Builder/" + GameData.towerData[i]["set"] + "/" + str(i)).text = str(round(towerList[i]["price"] * GameData.diffData[diff]["priceMod"])) + "$"


func _on_button_pressed():
	var wiki = towerwiki.instantiate()
	wiki.gDiff = diff
	wiki.leave.connect(wikileave.bind(self))
	get_parent().add_child(wiki)
	wiki.fillInfo("turret")
	towerwikiopen = true

func wikileave(obj):
	obj.queue_free()
