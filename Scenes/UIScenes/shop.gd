extends Panel

var towerList = GameData.shopData

func _ready():
	for i in towerList:
		get_node("Margin/ScrollContainer/BuilderMargin/Builder/" + GameData.towerData[i]["set"] + "/" + str(i)).text = str(towerList[i]["price"]) + "$"
