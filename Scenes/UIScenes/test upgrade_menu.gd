extends Control

var tower
var path1Btn
var path2Btn

func _ready():
	path1Btn = $Background/Margin/Body/UpgradeMgr/VBoxContainer/Path1Btn
	path2Btn = $Background/Margin/Body/UpgradeMgr/VBoxContainer2/Path2Btn

func _on_upgrade_p1_pressed():
				var tempDmg = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("dmgup"):
					tempDmg = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["dmgup"]
				
				var tempAS = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("asup"):
					tempAS = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["asup"]
				
				var tempRange = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("rangeup"):
					tempRange = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["rangeup"]
				
				var tempAOE = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("aoeup"):
					tempAOE = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["aoeup"]
				
				var tempBS = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("bulletspeedup"):
					tempBS = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["bulletspeedup"]
				
				var tempAng = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("angup"):
					tempAng = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["angup"]
				
				var tempPDmg = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("pDmgup"):
					tempPDmg = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["pDmgup"]
				
				var tempSlow = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("slowup"):
					tempSlow = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["slowup"]
				
				var tempTime = 0
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("timeup"):
					tempTime = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["timeup"]
				
				if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0]+1].has("special"):
					tower.specialUpgrade(tower.upgrade[0] + 1, 1)
				
				tower.upgradeUnit(tempDmg, tempRange, tempAS, tempAOE, tempBS, tempAng, tempPDmg, tempSlow, tempTime)
				tower.price += GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"]
				tower.upgrade[0] += 1


func _on_upgrade_p2_pressed():
				var tempDmg = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("dmgup"):
					tempDmg = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["dmgup"]
				
				var tempAS = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("asup"):
					tempAS = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["asup"]
				
				var tempRange = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("rangeup"):
					tempRange = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["rangeup"]
				
				var tempAOE = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("aoeup"):
					tempAOE = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["aoeup"]
				
				var tempBS = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("bulletspeedup"):
					tempBS = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["bulletspeedup"]
				
				var tempAng = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("angup"):
					tempAng = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["angup"]
				
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1]+1].has("special"):
					tower.specialUpgrade(tower.upgrade[1] + 1, 2)
				
				var tempPDmg = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("pDmgup"):
					tempPDmg = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["pDmgup"]
				
				var tempSlow = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("slowup"):
					tempSlow = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["slowup"]
				
				var tempTime = 0
				if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("timeup"):
					tempTime = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["timeup"]
				
				
				tower.upgradeUnit(tempDmg, tempRange, tempAS, tempAOE, tempBS, tempAng, tempPDmg, tempSlow, tempTime)
				tower.price += GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"]
				tower.upgrade[1] += 1
