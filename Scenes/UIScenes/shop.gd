extends Panel

var towerList = GameData.shopData
@onready var set1 = $Margin/ScrollContainer/BuilderMargin/Builder/Set1

func _ready():
	for i in towerList:
		set1.get_node(i).text = str(towerList[i]["price"])
