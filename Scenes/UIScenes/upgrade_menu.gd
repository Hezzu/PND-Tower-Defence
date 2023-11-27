extends Control

signal deductMoney(amount)
signal unitSold(Refund)
signal moneyCheck

var money
var selectedTower

var headline
var statText1
var statText2
var p1Text1
var p1Text2
var p1Special
var p2Text1
var p2Text2
var p2Special
var p1BtnLb
var p2BtnLb
var sellBtnLb
var p1lock
var p2lock

func _ready():
	headline =  $UpgradeMargin/UpgradeMain/Unit
	statText1 = $UpgradeMargin/UpgradeMain/StatPane/StatBox/Stats
	statText2 = $UpgradeMargin/UpgradeMain/StatPane/StatBox/Stats2
	p1Text1 = $UpgradeMargin/UpgradeMain/UpgradePane/Path1Box/Stats
	p1Text2 = $UpgradeMargin/UpgradeMain/UpgradePane/Path1Box/Stats2
	p1Special = $UpgradeMargin/UpgradeMain/UpgradePane/HeadlinePath1
	p2Text1 = $UpgradeMargin/UpgradeMain/UpgradePane2/Path2Box/Stats
	p2Text2 = $UpgradeMargin/UpgradeMain/UpgradePane2/Path2Box/Stats2
	p2Special = $UpgradeMargin/UpgradeMain/UpgradePane2/HeadlinePath2
	p1BtnLb = $UpgradeMargin/UpgradeMain/UpgradeCont/Path1/UpgradePane/Upgrade/Label
	p2BtnLb = $UpgradeMargin/UpgradeMain/UpgradeCont/Path2/UpgradePane/Upgrade/Label
	sellBtnLb = $UpgradeMargin/UpgradeMain/Panel/Sell/SellLabel
	p1lock = false
	p2lock = false

func fillInfo(unit):
	selectedTower = unit
	headline.text = str(unit.tower)
	statText1.text = "DMG: " + str(unit.dmg) + "\nRANGE: " + str(unit.range) + "\nATTACK SPEED: " + str(unit.attackSpeed) + "\nPRICE: " + str(unit.price)
	statText2.text = "\nANGLE: " + str(unit.angle)
	if GameData.bulletData[GameData.towerData[unit.tower]["projectile"]].has("aoe"):
		statText2.text += "\nAOE: " + str(unit.aoeRad)
	statText2.text +=  "\nBULLET SPD: " + str(unit.bSpeed)
	sellBtnLb.text = "SELL UNIT: + " + str(round(0.7 * unit.price)) + "$"
	for i in unit.upgrade[0]:
		makeStyleBoxUnique(get_node("UpgradeMargin/UpgradeMain/UpgradeCont/Path1/Path1Leds/LED" + str(i+1)), get_node("UpgradeMargin/UpgradeMain/UpgradeCont/Path1/Path1Leds/LED" + str(i+1)).get_theme_stylebox("panel", "Panel"), i+1)
	for i in unit.upgrade[1]:
		makeStyleBoxUnique(get_node("UpgradeMargin/UpgradeMain/UpgradeCont/Path2/Path2Leds/LED" + str(i+1)), get_node("UpgradeMargin/UpgradeMain/UpgradeCont/Path2/Path2Leds/LED" + str(i+1)).get_theme_stylebox("panel", "Panel"), i+1)
	if unit.upgrade[0] > 2 and unit.upgrade[1] == 2:
		p2lock = true
	if unit.upgrade[1] > 2 and unit.upgrade[0] == 2:
		p1lock = true
	fillUpgradeInfoP1(unit, unit.tower, unit.upgrade)
	fillUpgradeInfoP2(unit, unit.tower, unit.upgrade)

func makeStyleBoxUnique(node, stylebox, upgrade):
	var nSB = StyleBoxFlat.new()
	nSB.set_border_width_all(3)
	nSB.set_corner_radius_all(20)
	nSB.border_color = Color("ffffff")
	nSB.border_blend = true
	nSB.draw_center = true
	match upgrade:
		1, 2: nSB.bg_color = Color("ffffff")
		3: nSB.bg_color = Color("6b9f00ab")
		4: nSB.bg_color = Color("e9000cab")
	node.add_theme_stylebox_override("panel", nSB)
func fillUpgradeInfoP1(tower, unit, upgrades):
	if upgrades[0] < GameData.upgradeData[unit]["p1"].size() and p1lock == false:
		p1Text1.text = ""
		p1Text2.text = ""
		if GameData.upgradeData[unit]["p1"][upgrades[0] + 1].has("dmgup"):
			p1Text1.text += "\nDMG: " + str(tower.dmg) + " > " + str(tower.dmg + GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["dmgup"])
		if GameData.upgradeData[unit]["p1"][upgrades[0] + 1].has("rangeup"):
			p1Text1.text += "\nRANGE: " + str(tower.range) + " > " + str(tower.range + GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["rangeup"])
		if GameData.upgradeData[unit]["p1"][upgrades[0] + 1].has("asup"):
			p1Text1.text += "\nATTACK SPEED:\n" + str(tower.attackSpeed) + " > " + str(tower.attackSpeed + GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["asup"])
		if GameData.upgradeData[unit]["p1"][upgrades[0] + 1].has("aoeup"):
			p1Text2.text += "\nAOE: " + str(tower.aoeRad) + " > " + str(tower.aoeRad + GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["aoeup"])
		if GameData.upgradeData[unit]["p1"][upgrades[0] + 1].has("bulletspeedup"):
			p1Text2.text += "\nBULLET SPD:\n" + str(tower.bSpeed) + " > " + str(tower.bSpeed + GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["bulletspeedup"])
		if GameData.upgradeData[unit]["p1"][upgrades[0] + 1].has("angup"):
			p1Text2.text += "\nANGLE: " + str(tower.angle) + " > " + str(tower.angle + GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["angup"])
		p1BtnLb.text = "Path 1: " + str(GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["price"]) + "$"
		if GameData.upgradeData[unit]["p1"][upgrades[0]+1].has("special"):
			p1Special.text = "\n" + str(GameData.upgradeData[unit]["p1"][upgrades[0] + 1]["special"])
	else:
		if upgrades[0] == 4:
			p1Special.text = str(GameData.upgradeData[unit]["p1"][upgrades[0]]["special"])
		else:
			p1Special.text = "Path 1:"
		p1Text1.text = "Maxed Out"
		p1Text2.text = ""
		p1BtnLb.text = "Max"


func fillUpgradeInfoP2(tower, unit, upgrades):
	if upgrades[1] < GameData.upgradeData[unit]["p2"].size() and p2lock == false:
		p2Text1.text = ""
		p2Text2.text = ""
		if GameData.upgradeData[unit]["p2"][upgrades[1] + 1].has("dmgup"):
			p2Text1.text += "\nDMG: " + str(tower.dmg) + " > " + str(tower.dmg + GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["dmgup"])
		if GameData.upgradeData[unit]["p2"][upgrades[1] + 1].has("rangeup"):
			p2Text1.text += "\nRANGE: " + str(tower.range) + " > " + str(tower.range + GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["rangeup"])
		if GameData.upgradeData[unit]["p2"][upgrades[1] + 1].has("asup"):
			p2Text1.text += "\nATTACK SPEED:\n" + str(tower.attackSpeed) + " > " + str(tower.attackSpeed + GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["asup"])
		if GameData.upgradeData[unit]["p2"][upgrades[1] + 1].has("aoeup"):
			p2Text2.text += "\nAOE: " + str(tower.aoeRad) + " > " + str(tower.aoeRad + GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["aoeup"])
		if GameData.upgradeData[unit]["p2"][upgrades[1] + 1].has("bulletspeedup"):
			p2Text2.text += "\nBULLET SPD:\n" + str(tower.bSpeed) + " > " + str(tower.bSpeed + GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["bulletspeedup"])
		if GameData.upgradeData[unit]["p2"][upgrades[1] + 1].has("angup"):
			p2Text2.text += "\nANGLE: " + str(tower.angle) + " > " + str(tower.angle + GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["angup"])
		p2BtnLb.text = "Path 2: " + str(GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["price"]) + "$"
		if GameData.upgradeData[unit]["p2"][upgrades[1]+1].has("special"):
			p2Special.text = "\n" + str(GameData.upgradeData[unit]["p2"][upgrades[1] + 1]["special"])
	else:
		if upgrades[1] == 4:
			p2Special.text = str(GameData.upgradeData[unit]["p2"][upgrades[1]]["special"])
		else: 
			p2Special.text = "Path 2:"
		p2Text1.text = "Maxed Out"
		p2Text2.text = ""
		p2BtnLb.text = "Max"


func _on_upgrade_p1_pressed():
	emit_signal("moneyCheck")
	if selectedTower.upgrade[0] < GameData.upgradeData[selectedTower.tower]["p1"].size() and p1lock == false:
		if money >= GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["price"]:
			var tempDmg = 0
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1].has("dmgup"):
				tempDmg = GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["dmgup"]
			
			var tempAS = 0
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1].has("asup"):
				tempAS = GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["asup"]
			
			var tempRange = 0
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1].has("rangeup"):
				tempRange = GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["rangeup"]
			
			var tempAOE = 0
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1].has("aoeup"):
				tempAOE = GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["aoeup"]
			
			var tempBS = 0
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1].has("bulletspeedup"):
				tempBS = GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["bulletspeedup"]
			
			var tempAng = 0
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1].has("angup"):
				tempAng = GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["angup"]
			
			if GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0]+1].has("special"):
				selectedTower.specialUpgrade(selectedTower.upgrade[0] + 1, 1)
			
			emit_signal("deductMoney", GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["price"])
			selectedTower.upgradeUnit(tempDmg, tempRange, tempAS, tempAOE, tempBS, tempAng)
			selectedTower.price += GameData.upgradeData[selectedTower.tower]["p1"][selectedTower.upgrade[0] + 1]["price"]
			selectedTower.upgrade[0] += 1
			fillInfo(selectedTower)
#upgradeUnit(damage = 0, nRange = 0, nAttackSpeed = 0, aoe = 0, bulletSpeed = 0):


func _on_upgrade_p2_pressed():
	emit_signal("moneyCheck")
	if selectedTower.upgrade[1] < GameData.upgradeData[selectedTower.tower]["p2"].size() and p2lock == false:
		if money >= GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["price"]:
			var tempDmg = 0
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1].has("dmgup"):
				tempDmg = GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["dmgup"]
			
			var tempAS = 0
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1].has("asup"):
				tempAS = GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["asup"]
			
			var tempRange = 0
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1].has("rangeup"):
				tempRange = GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["rangeup"]
			
			var tempAOE = 0
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1].has("aoeup"):
				tempAOE = GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["aoeup"]
			
			var tempBS = 0
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1].has("bulletspeedup"):
				tempBS = GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["bulletspeedup"]
			
			var tempAng = 0
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1].has("angup"):
				tempAng = GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["angup"]
			
			if GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1]+1].has("special"):
				selectedTower.specialUpgrade(selectedTower.upgrade[1] + 1, 2)
			
			emit_signal("deductMoney", GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["price"])
			selectedTower.upgradeUnit(tempDmg, tempRange, tempAS, tempAOE, tempBS, tempAng)
			selectedTower.price += GameData.upgradeData[selectedTower.tower]["p2"][selectedTower.upgrade[1] + 1]["price"]
			selectedTower.upgrade[1] += 1
			fillInfo(selectedTower)


func _on_sell_pressed():
	emit_signal("unitSold", round(selectedTower.price * 0.7))
