extends Panel

var towerList = GameData.shopData
@onready var diff = get_parent().get_parent().get_parent().diff

func _ready():
	for i in towerList:
		get_node("Margin/ScrollContainer/BuilderMargin/Builder/" + GameData.towerData[i]["set"] + "/" + str(i)).text = str(round(towerList[i]["price"] * GameData.diffData[diff]["priceMod"])) + "$"
