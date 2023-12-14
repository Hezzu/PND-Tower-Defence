extends Control

signal deductMoney(amount)
signal unitSold(Refund)
signal moneyCheck

var money
var tower

var conf1 = false
var conf2 = false

var headline
var tier
var spent
var target
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
	target = $Background/Margin/Body/Targeting
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
	if GameData.towerData[tower.tower].has("dmg"):
		stats.text += "Damage: " + str(tower.dmg)
	if GameData.towerData[tower.tower].has("range"):
		stats.text += "\nRange: " + str(tower.range)
	if GameData.towerData[tower.tower].has("angle"):
		stats.text += "\nAngle: " + str(tower.angle)
	if GameData.towerData[tower.tower].has("as"):
		stats.text += "\nAttack Cooldown: " + str(tower.attackSpeed)
	if GameData.towerData[tower.tower].has("projectile"):
		stats.text += "\nBullet Speed: " + str(tower.bSpeed)
	if GameData.towerData[tower.tower].has("time"):
		stats.text += "\nSlow Time: " + str(tower.time) + " sec"
	if GameData.towerData[tower.tower].has("slow"):
		stats.text += "\nSlow Amount: " + str(tower.slow * 100) + "%"
	if GameData.towerData[tower.tower].has("pDmg"):
		stats.text += "\n% Health Damage: " + str(tower.percDmg * 100) + "%"
	if GameData.towerData[tower.tower].has("projectile"):
		if GameData.bulletData[GameData.towerData[tower.tower]["projectile"]].has("aoe"):
			stats.text += "\nArea of Effect: " + str(tower.aoeRad)
	if tower.upgrade[0] > 2 and tower.upgrade[1] == 2:
		p2lock = true
	if tower.upgrade[1] > 2 and tower.upgrade[0] == 2:
		p1lock = true
	if tower.upgrade[0] < GameData.upgradeData[tower.tower]["p1"].size() and p1lock == false:
		path1Btn.text = "Path 1\n" + str(GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["special"]) + "\nPrice: " + str(GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"]) + "$"
	else:
		path1Btn.text = "Path 1\nMax"
	if tower.upgrade[1] < GameData.upgradeData[tower.tower]["p2"].size() and p2lock == false:
		path2Btn.text = "Path 2\n" + str(GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["special"]) + "\nPrice: " + str(GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"]) + "$"
	else:
		path2Btn.text = "Path 2\nMax"
	for i in tower.upgrade[0]:
		makeStyleBoxUnique(get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer/Path1/LED" + str(i+1)), get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer/Path1/LED" + str(i+1)).get_theme_stylebox("panel", "Panel"), i+1)
	for i in tower.upgrade[1]:
		makeStyleBoxUnique(get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer2/Path2/LED" + str(i+1)), get_node("Background/Margin/Body/UpgradeMgr/VBoxContainer2/Path2/LED" + str(i+1)).get_theme_stylebox("panel", "Panel"), i+1)
	sell.text = "Sell tower: +" + str(round(0.7 * tower.price)) + "$"
#	fillUpgradeInfoP1()
#	fillUpgradeInfoP2()

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
		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("dmgup"):
			stats.text += "Damage: " + str(tower.dmg) + " > " + str(tower.dmg + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["dmgup"])
		elif tower.dmg != 0:
			stats.text += "Damage: " + str(tower.dmg)


		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("rangeup"):
			stats.text += "\nRange: " + str(tower.range) + " > " + str(tower.range + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["rangeup"])
		elif tower.range != 0:
			stats.text += "\nRange: " + str(tower.range)


		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("angup"):
			stats.text += "\nAngle: " + str(tower.angle) + " > " + str(tower.angle + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["angup"])
		elif tower.angle != 0:
			stats.text += "\nAngle: " + str(tower.angle)


		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("asup"):
			stats.text += "\nAttack Cooldown: " + str(tower.attackSpeed) + " > " + str(tower.attackSpeed + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["asup"])
		elif tower.attackSpeed != 0:
			stats.text += "\nAttack Cooldown: " + str(tower.attackSpeed)


		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("bulletspeedup"):
			stats.text += "\nBullet Speed: " + str(tower.bSpeed) + " > " + str(tower.bSpeed + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["bulletspeedup"])
		elif tower.bSpeed != 0:
			stats.text += "\nBullet Speed: " + str(tower.bSpeed)


		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("aoeup"):
			stats.text += "\nArea of Effect: " + str(tower.aoeRad) + " > " + str(tower.slow + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["aoeup"])
		elif tower.aoeRad != 0:
			stats.text += "\nArea of Effect: " + str(tower.aoeRad)
		
		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("timeup"):
			stats.text += "\nSlow Time: " + str(tower.time) + " sec > " + str(tower.time + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["timeup"]) + " sec"
		elif tower.time != 0:
			stats.text += "\nSlow Time: " + str(tower.time) + " sec"
		
		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("slowup"):
			stats.text += "\nSlow Amount: " + str(tower.slow * 100) + "% > " + str((tower.slow + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["slowup"]) * 100) + "%"
		elif tower.slow != 0:
			stats.text += "\nSlow Amount: " + str(tower.slow * 100) + "%"
		
		if GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1].has("pDmgup"):
			stats.text += "\n% Health Damage: " + str(tower.percDmg * 100) + "% > " + str((tower.percDmg + GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["pDmgup"]) * 100) + "%"
		elif tower.percDmg != 0:
			stats.text += "\n% Health Damage: " + str(tower.percDmg * 100) + "%"

func fillUpgradeInfoP2():
	if tower.upgrade[1] < GameData.upgradeData[tower.tower]["p2"].size() and p2lock == false:
		stats.text = ""
		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("dmgup"):
			stats.text += "Damage: " + str(tower.dmg) + " > " + str(tower.dmg + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["dmgup"])
		elif tower.dmg != 0:
			stats.text += "Damage: " + str(tower.dmg)


		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("rangeup"):
			stats.text += "\nRange: " + str(tower.range) + " > " + str(tower.range + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["rangeup"])
		elif tower.range != 0:
			stats.text += "\nRange: " + str(tower.range)


		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("angup"):
			stats.text += "\nAngle: " + str(tower.angle) + " > " + str(tower.angle + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["angup"])
		elif tower.angle != 0:
			stats.text += "\nAngle: " + str(tower.angle)


		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("asup"):
			stats.text += "\nAttack Cooldown: " + str(tower.attackSpeed) + " > " + str(tower.attackSpeed + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["asup"])
		elif tower.attackSpeed != 0:
			stats.text += "\nAttack Cooldown: " + str(tower.attackSpeed)


		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("bulletspeedup"):
			stats.text += "\nBullet Speed: " + str(tower.bSpeed) + " > " + str(tower.bSpeed + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["bulletspeedup"])
		elif tower.bSpeed != 0:
			stats.text += "\nBullet Speed: " + str(tower.bSpeed)


		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("aoeup"):
			stats.text += "\nArea of Effect: " + str(tower.aoeRad) + " > " + str(tower.aoeRad + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["aoeup"])
		elif tower.aoeRad != 0:
			stats.text += "\nArea of Effect: " + str(tower.aoeRad)
		
		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("timeup"):
			stats.text += "\nSlow Time: " + str(tower.time) + " sec > " + str(tower.time + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["timeup"]) + " sec"
		elif tower.time != 0:
			stats.text += "\nSlow Time: " + str(tower.time) + " sec"
		
		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("slowup"):
			stats.text += "\nSlow Amount: " + str(tower.slow * 100) + "% > " + str((tower.slow + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["slowup"])*100) + "%"
		elif tower.slow != 0:
			stats.text += "\nSlow Amount: " + str(tower.slow * 100) + "%"
		
		if GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1].has("pDmgup"):
			stats.text += "\n% Health Damage: " + str(tower.percDmg * 100) + "% > " + str((tower.percDmg + GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["pDmgup"]) * 100) + "%"
		elif tower.percDmg != 0:
			stats.text += "\n% Health Damage: " + str(tower.percDmg * 100) + "%"


func _on_upgrade_p1_pressed():
	emit_signal("moneyCheck")
	if tower.upgrade[0] < GameData.upgradeData[tower.tower]["p1"].size() and p1lock == false:
		if conf1:
			if money >= GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"]:
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
				
				emit_signal("deductMoney", GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"])
				tower.upgradeUnit(tempDmg, tempRange, tempAS, tempAOE, tempBS, tempAng, tempPDmg, tempSlow, tempTime)
				tower.price += GameData.upgradeData[tower.tower]["p1"][tower.upgrade[0] + 1]["price"]
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
			if money >= GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"]:
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
				
				
				emit_signal("deductMoney", GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"])
				tower.upgradeUnit(tempDmg, tempRange, tempAS, tempAOE, tempBS, tempAng, tempPDmg, tempSlow, tempTime)
				tower.price += GameData.upgradeData[tower.tower]["p2"][tower.upgrade[1] + 1]["price"]
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
