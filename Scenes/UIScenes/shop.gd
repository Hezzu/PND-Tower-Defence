extends PanelContainer
var towerwiki = preload("res://Scenes/UIScenes/tower_info.tscn")
var towerwikiopen = false

@onready var diff = get_parent().get_parent().get_parent().diff

func _ready():
	for i in get_tree().get_nodes_in_group("buildBtn"):
		i.text = str(GameData.towerData[i.name]["price"] * GameData.diffData[diff]["priceMod"]) + "$"
		if GameData.towerData[i.name]["unlocked"]:
			i.disabled = false


func _on_button_pressed():
	var wiki = towerwiki.instantiate()
	wiki.gDiff = diff
	wiki.leave.connect(wikileave.bind(wiki))
	get_parent().add_child(wiki)
	wiki.fillInfo("turret")
	towerwikiopen = true

func wikileave(obj):
	obj.queue_free()
