extends Control

signal deductMoney(amount)
signal unitSold(Refund)
signal moneyCheck

var diff
var money
var tower

var conf1 = false
var conf2 = false

var headline
var tier
var spent
var target
var tName
var stats
var path1Btn
var path2Btn
var sell
var p1lock
var p2lock

func _ready():
	headline =  $Background/Margin/Body/Header/Header/Unit
	tier = $Background/Margin/Body/Header/Header/Tier
	spent = $Background/Margin/Body/Header/Spent
	target = $Background/Margin/Body/Header/Targeting
	tName = $Background/Margin/Body/Name
	stats = $Background/Margin/Body/Stats
	path1Btn = $Background/Margin/Body/UpgradeMgr/VBoxContainer/Path1Btn
	path2Btn = $Background/Margin/Body/UpgradeMgr/VBoxContainer2/Path2Btn
	sell = $Background/Margin/Body/Sell
	p1lock = false
	p2lock = false

func fillInfo():
	headline.text = str(tower.tower)
	tier.text = str(tower.upgrade[0]) + " | " + str(tower.upgrade[1])
	target.text = "Targeting: " + tower.targeting[tower.currentTargeting]
	spent.text = "Spent: " + str(tower.price)
	stats.text = ""
	tName.text = ""
	for j in tower.stats:
		if  tower.stats[j] > 0:
			match(j):
				"Slow Amount":
					stats.text += j + ": " + str(tower.stats[j]*100) + "%\n"
				"Percentage Damage":
					stats.text += j + ": " + str(tower.stats[j]*100) + "%\n"
				"Damage":
					stats.text += j + ": " + str(tower.stats[j] * GameData.towerData[tower.tower]["dmgInc"]) + "\n"
				_:
					stats.text += j + ": " + str(tower.stats[j]) + "\n"
	if tower.upgrade[0] > 2 and tower.upgrade[1] == 2:
		p2lock = true
	if tower.upgrade[1] > 2 and tower.upgrade[0] == 2:
		p1lock = true
	if tower.upgrade[0] < GameData.upgradeData[tower.tower]["p1"].size() and p1lock == false:
		path1Btn.text = "Path 1\n" + "\nPrice: " + str(round(GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"] * GameData.diffData[diff]["priceMod"])) + "$"
	else:
		path1Btn.text = "Path 1\nMax"
	if tower.upgrade[1] < GameData.upgradeData[tower.tower]["p2"].size() and p2lock == false:
		path2Btn.text = "Path 2\n" + "\nPrice: " + str(round(GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"] * GameData.diffData[diff]["priceMod"])) + "$"
	else:
		path2Btn.text = "Path 2\nMax"
	for i in tower.upgrade[0]:
		makeStyleBoxUnique(get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer/Path1/LED" + str(i+1)), get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer/Path1/LED" + str(i+1)).get_theme_stylebox("panel", "Panel"), i+1)
	for i in tower.upgrade[1]:
		makeStyleBoxUnique(get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer2/Path2/LED" + str(i+1)), get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer2/Path2/LED" + str(i+1)).get_theme_stylebox("panel", "Panel"), i+1)
	sell.text = "Sell tower: +" + str(round(0.7 * tower.price)) + "$"

func makeStyleBoxUnique(node, stylebox, upgrade):
	var nSB = StyleBoxFlat.new()
	nSB.set_border_width_all(2)
	nSB.set_corner_radius_all(5)
	nSB.border_color = Color("ffffff")
	nSB.border_blend = true
	nSB.draw_center = true
	match upgrade:
		1, 2: nSB.bg_color = Color("ffffff")
		3: nSB.bg_color = Color("6b9f00ab")
		4: nSB.bg_color = Color("e9000cab")
	node.add_theme_stylebox_override("panel", nSB)

func fillUpgradeInfoP1():
	if tower.upgrade[0] < GameData.upgradeData[tower.tower]["p1"].size() and p1lock == false:
		stats.text = ""
		tName.text = ""
		tName.text = GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["Name"]
		for i in tower.stats:
			checkUpgrades("p1", tower.upgrade[0] + 1, i)

func fillUpgradeInfoP2():
	if tower.upgrade[1] < GameData.upgradeData[tower.tower]["p2"].size() and p2lock == false:
		stats.text = ""
		tName.text = ""
		tName.text = GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["Name"]
		for i in tower.stats:
			checkUpgrades("p2", tower.upgrade[1] + 1, i)

func checkUpgrades(path, tier, type):
	if GameData.upgradeData[tower.tower][path][tier].has(type) && type == "Slow Amount" || GameData.upgradeData[tower.tower][path][tier].has(type) && type == "Percentage Damage":
		stats.text += type + ": " + str(tower.stats[type]*100) + "% > " + str((tower.stats[type] + GameData.upgradeData[tower.tower][path][tier][type])*100) + "%\n";
	elif GameData.upgradeData[tower.tower][path][tier].has(type):
		stats.text += type + ": " + str(tower.stats[type]) + " > " + str(tower.stats[type] + GameData.upgradeData[tower.tower][path][tier][type]) + "\n"
	elif tower.stats[type] != 0 && type == "Slow Amount" || tower.stats[type] != 0 && type == "Percentage Damage":
		stats.text += type + ": " + str(tower.stats[type]*100) + "%\n"
	elif tower.stats[type] != 0:
		stats.text += type + ": " + str(tower.stats[type]) + "\n"

func makeUpgrades(path, tier, type):
	if GameData.upgradeData[tower.tower][path][tier].has(type):
		return GameData.upgradeData[tower.tower][path][tier][type]
	else:
		return 0

func _on_upgrade_p1_pressed():
	emit_signal("moneyCheck")
	if tower.upgrade[0] < GameData.upgradeData[tower.tower]["p1"].size() and p1lock == false:
		if conf1:
			if money >= round(GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"]  * GameData.diffData[diff]["priceMod"]):
				var tempStats = []
				var inc = 0
				for i in tower.stats:
					tempStats.append(makeUpgrades("p1", tower.upgrade[0] + 1, i))
					inc += 1
				tower.specialUpgrade(tower.upgrade[0] + 1, 1)
				emit_signal("deductMoney", round(GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"] * GameData.diffData[diff]["priceMod"]))
				tower.upgradeUnit(tempStats[0], tempStats[1], tempStats[2], tempStats[3], tempStats[4], tempStats[5], tempStats[6], tempStats[7], tempStats[8])
				tower.price += round(GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"] * GameData.diffData[diff]["priceMod"])
				tower.upgrade[0] += 1
				fillInfo()
				conf1 = false
				conf2 = false
		else:
			fillUpgradeInfoP1()
			conf1 = true
			conf2 = false
#upgradeUnit(damage = 0, nRange = 0, nAttackSpeed = 0, aoe = 0, bulletSpeed = 0):


func _on_upgrade_p2_pressed():
	emit_signal("moneyCheck")
	if tower.upgrade[1] < GameData.upgradeData[tower.tower]["p2"].size() and p2lock == false:
		if conf2:
			if money >= round(GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"] * GameData.diffData[diff]["priceMod"]):
				var tempStats = []
				var inc = 0
				for i in tower.stats:
					tempStats.append(makeUpgrades("p2", tower.upgrade[1] + 1, i))
					inc += 1
				tower.specialUpgrade(tower.upgrade[1] + 1, 2)
				emit_signal("deductMoney", GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"] * GameData.diffData[diff]["priceMod"])
				tower.upgradeUnit(tempStats[0], tempStats[1], tempStats[2], tempStats[3], tempStats[4], tempStats[5], tempStats[6], tempStats[7], tempStats[8])
				tower.price += round(GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"] * GameData.diffData[diff]["priceMod"])
				tower.upgrade[1] += 1
				fillInfo()
				conf2 = false
				conf1 = false
		else:
			fillUpgradeInfoP2()
			conf2 = true
			conf1 = false


func _on_sell_pressed():
	emit_signal("unitSold", round(tower.price * 0.7))


func _on_targeting_pressed():
	if tower.targeting.size() > 1:
		tower.currentTargeting = wrapi(tower.currentTargeting + 1, 0, tower.targeting.size())
		wrapi(tower.currentTargeting, 0, tower.targeting.size() - 1)
		target.text = "Targeting: " + tower.targeting[tower.currentTargeting]
