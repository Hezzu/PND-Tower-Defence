extends Node

var gameData = {
	"StartMoney": 450,
	"MaxSpeed": 2.0,
	"CashPerWave": 10
}


var towerData = {
	"turret":{
		"dmg": 10,
		"range": 100,
		"as": 2,
		"angle": 260,
		"placement area": 32,
		"projectile": "bullet",
		"set": "Set1",
		"placement": "ground",
		},
	"rocket":{
		"dmg": 25,
		"range": 160,
		"as": 5,
		"angle": 320,
		"placement area": 21,
		"projectile": "missle",
		"set": "Set1",
		"placement": "ground",
		},
	"roadblock":{
		"dmg": 5,
		"pDmg": 0.005,
		"slow": 0.05,
		"time": 4,
		"set": "Set2",
		"placement": "road",
		}
}
var enemyData = {
	"yellowtank":{
		"speed": 20,
		"hp": 50,
		"base_dmg": 1,
		"KillGold": 5,
		"UFGain": 0.1
	},
	"greentank":{
		"speed": 25,
		"hp": 70,
		"base_dmg": 3,
		"KillGold": 8,
		"UFGain": 0.2
	},
	"bluetank":{
		"speed": 30,
		"hp": 100,
		"base_dmg": 5,
		"KillGold": 12,
		"UFGain": 0.3
	},
	"greytank":{
		"speed": 35,
		"hp": 140,
		"base_dmg": 8,
		"KillGold": 15,
		"UFGain": 0.4
	},
	"yellowminiboss":{
		"speed": 10,
		"hp": 250,
		"base_dmg": 50,
		"KillGold": 100,
		"UFGain": 5
	},
	"greenminiboss":{
		"speed": 13,
		"hp": 400,
		"base_dmg": 60,
		"KillGold": 150,
		"UFGain": 10
	},
	"blueminiboss":{
		"speed": 15,
		"hp": 700,
		"base_dmg": 80,
		"KillGold": 200,
		"UFGain": 15
	},
	"greyminiboss":{
		"speed": 18,
		"hp": 1200,
		"base_dmg": 100,
		"KillGold": 300,
		"UFGain": 20
	},
#	End of Easy Mode
	"whitetank":{
		"speed": 45,
		"hp": 280,
		"base_dmg": 10,
		"KillGold": 20,
		"UFGain": 0.6
	},
	"blacktank":{
		"speed": 20,
		"hp": 1100,
		"armor": 0.93,
		"base_dmg": 30,
		"KillGold": 30,
		"UFGain": 0.8,
	},
	"deepbluetank":{
		"speed": 40,
		"hp": 460,
		"base_dmg": 15,
		"KillGold": 35,
		"UFGain": 1,
	},
	"purpletank":{
		"speed": 45,
		"hp": 520,
		"armor": 0.9,
		"base_dmg": 20,
		"KillGold": 40,
		"UFGain": 1.2,
	},
	"redtank":{
		"speed": 50,
		"hp": 500,
		"base_dmg": 25,
		"KillGold": 60,
		"UFGain": 2
	},
	"redminiboss":{
		"speed": 20,
		"hp": 2300,
		"base_dmg": 95,
		"KillGold": 250,
		"UFGain": 10
	},
	"whiteminiboss":{
		"speed": 25,
		"hp": 1600,
		"base_dmg": 100,
		"KillGold": 400,
		"UFGain": 10
	},
	"blackminiboss":{
		"speed": 10,
		"hp": 42000,
		"armor": 0.8,
		"base_dmg": 100,
		"KillGold": 800,
		"UFGain": 25
	},
	"deepblueminiboss":{
		"speed": 18,
		"hp": 15000,
		"base_dmg": 100,
		"KillGold": 500,
		"UFGain": 20
	},
	"purpleminiboss":{
		"speed": 20,
		"hp": 25000,
		"armor": 0.85,
		"base_dmg": 250,
		"KillGold": 1500,
		"UFGain": 80
	},
	"yellowboss":{
		"speed": 7,
		"hp": 50000,
		"armor": 0.75,
		"base_dmg": 999,
		"KillGold": 2000,
		"UFGain": 200
	},
	"redboss":{
		"speed": 8,
		"hp": 38000,
		"base_dmg": 100,
		"KillGold": 1600,
		"UFGain": 100
	}
}
var bulletData = {
	"bullet":{
		"speed": 250,
		"dmgInc": 1
	},
	"missle":{
		"speed": 600,
		"aoe": 30,
		"dmgInc": 1,
		"aoeSMod": 1,
		"aoeMod": 0.5
	}
}
var previewData = {
	24: [[30, "white_tank", 0.7]],
	25: [[10, "red_tank", 1]],
	26: [[30, "white_tank", 1], [25, "white_tank", 0.7]],
	27: [[50, "white_tank", 1], [20, "white_tank", 0.7]],
	28: [[30, "white_tank", 0.7], [5, "white_tank", 1.5], [35, "white_tank", 0.5]],
	29: [[50, "blue_tank", 1], [40, "green_tank", 1], [30, "white_tank", 0.1], [30, "blue_tank", 0.7], [25, "green_tank", 0.7], [20, "white_tank", 0.3], [15, "red_tank", 0.7]],
	30: [[15, "red_tank", 0.5], [10, "red_tank", 0.7], [5, "red_tank", 0.5]],
	31: [[20, "red_tank", 0.3], [80, "green_tank", 0.1], [20, "white_tank", 0.2], [150, "blue_tank", 0.01]],
	32: [[30, "red_tank", 0.3], [70, "green_tank", 0.1], [50, "red_tank", 0.3]],
	33: [[50, "red_tank", 0.5], [40, "red_tank", 0.3], [200, "blue_tank", 0.5]],
	34: [[100, "red_tank", 0.7]],
	35: [[120, "blue_tank", 0.01], [100, "green_tank", 0.1], [80, "white_tank", 0.2], [80, "red_tank", 0.3], [1, "red_tank", 2.5], [2, "red_mini_boss", 5]],
	36: [[5, "red_mini_boss", 2.5]],
	37: [[200, "red_tank", 0.3]],
	38: [[120, "red_tank", 0.3], [1, "red_tank", 5], [35, "red_mini_boss", 2]],
	39: [[55, "red_mini_boss", 1]],
	40: [[1, "red_boss", 1]],
}

var diffData = {
	"Easy":{
		"moneyMod": 1.1,
		"waves": 40,
		"waveHpMod": 0,
		"waveSpeedMod": 0,
		"priceMod": 0.9,
		"baseHealth": 150,
		"ufMulti": 0.7
	},
	"Med":{
		"moneyMod": 1,
		"waves": 60,
		"waveHpMod": 0.01,
		"waveSpeedMod": 0.005,
		"priceMod": 1,
		"baseHealth": 100,
		"ufMulti": 1
	},
	"Hard":{
		"moneyMod": 0.7,
		"waves": 80,
		"waveHpMod": 0.05,
		"waveSpeedMod": 0.08,
		"priceMod": 1.3,
		"baseHealth": 10,
		"ufMulti": 10
	},
	"Leg":{
		"moneyMod": 0.5,
		"waves": 100,
		"waveHpMod": 0.1,
		"waveSpeedMod": 0.12,
		"priceMod": 1.5,
		"baseHealth": 1,
		"ufMulti": 50
	},
}


var waveData = {
#	1: [[1, "red_boss", 1]],
	1: [[5, "yellow_tank", 1.9]],
	2: [[8, "yellow_tank", 1.9]],
	3: [[10, "yellow_tank", 1.9]],
	4: [[12, "yellow_tank", 1.9]],
	5: [[4, "green_tank", 1.6]],
	6: [[12, "yellow_tank", 1.7], [2, "green_tank", 1.2]],
	7: [[18, "yellow_tank", 1.8], [4, "green_tank", 1.5]],
	8: [[19, "yellow_tank", 2.1], [1, "yellow_tank", 2.7], [6, "green_tank", 1.4]],
	9: [[9, "yellow_tank", 2.3], [1, "yellow_tank", 3], [19, "yellow_tank", 1.8	], [1, "yellow_tank", 1.5], [6, "green_tank", 1.4]],
	10: [[1, "yellow_mini_boss", 1]],
	11: [[12, "green_tank", 1.3]],
	12: [[16, "green_tank", 1.2]],
	13: [[18, "green_tank", 1.1]],
	14: [[22, "green_tank", 1]],
	15: [[16, "green_tank", 1.1], [10, "green_tank", 1], [2, "blue_tank", 1.4]],
	16: [[22, "green_tank", 1.1], [4, "blue_tank", 1.2]],
	17: [[26, "green_tank", 1.1], [8, "blue_tank", 1.1]],
	18: [[24, "green_tank", 0.8], [12, "blue_tank", 1.5]],
	19: [[40, "green_tank", 1], [16, "blue_tank", 1.8]],
	20: [[1, "green_mini_boss", 1]],
	21: [[20, "blue_tank", 1.2]],
	22: [[26, "blue_tank", 1.4]],
	23: [[30, "blue_tank", 1.3]],
	24: [[24, "blue_tank", 0.7]],
	25: [[8, "grey_tank", 1]],
	26: [[20, "blue_tank", 1], [1, "blue_tank", 1.8], [19, "blue_tank", 0.6]],
	27: [[32, "blue_tank", 1.2], [16, "blue_tank", 0.5], [10, "grey_tank", 1]],
	28: [[30, "blue_tank", 0.9], [20, "blue_tank", 0.5], [14, "grey_tank", 0.9]],
	29: [[30, "blue_tank", 0.6], [20, "grey_tank", 1]],
	30: [[1, "blue_mini_boss", 1]],
	31: [[26, "grey_tank", 1]],
	32: [[36, "grey_tank", 1]],
	33: [[50, "grey_tank", 1.2]],
	34: [[40, "grey_tank", 1]],
	35: [[60, "grey_tank", 1], [50, "blue_tank", 0.5], [40, "green_tank", 0.5], [20, "yellow_tank", 0.7], [4, "yellow_mini_boss", 10]],
	36: [[60, "grey_tank", 1]],
	37: [[40, "grey_tank", 0.6], [4, "green_mini_boss", 5]],
	38: [[60, "grey_tank", 1], [10, "yellow_mini_boss", 5], [6, "green_mini_boss", 4], [4, "blue_mini_boss", 3]],
	39: [[20, "yellow_mini_boss", 1.5], [15, "green_mini_boss", 1], [10, "blue_mini_boss", 1.5]],
	40: [[1, "grey_mini_boss", 1]],
	41: [[5, "deep_blue_tank", 1], [25, "grey_tank", 1]],
	42: [[10, "deep_blue_tank", 1], [5, "blue_mini_boss", 1], [35, "grey_tank", 1]],
	43: [[15, "deep_blue_tank", 0.9], [5, "white_tank", 2.5]],
	44: [[10, "white_tank", 3], [3, "grey_mini_boss", 5], [20, "deep_blue_tank", 1]],
	45: [[1, "white_mini_boss", 1]],
	46: [[40, "deep_blue_tank", 1], [10, "white_tank", 1], [1, "white_mini_boss", 1]],
	47: [[5, "black_tank", 2], [15, "white_tank", 1], [45, "deep_blue_tank", 1]],
	48: [[10, "grey_mini_boss", 1], [2, "white_mini_boss", 2], [55, "deep_blue_tank", 1], [20, "white_tank", 1]],
	49: [[60, "deep_blue_tank", 1], [30, "white_tank", 1.5], [30, "black_tank", 1], [10, "white_mini_boss", 1]],
	50: [[1, "deep_blue_mini_boss", 1]],
	51: [[20, "black_tank", 1]],
	52: [[60, "deep_blue_tank", 1], [50, "white_tank", 1], [25, "black_tank", 1]],
	53: [[25, "white_mini_boss", 1], [5, "purple_tank", 1]],
	54: [[20, "purple_tank", 1]],
	55: [[1, "black_mini_boss", 1]],
	56: [[25, "purple_tank", 1], [40, "white_tank", 1], [15, "white_mini_boss", 1], [1, "black_mini_boss", 1]],
	57: [[30, "purple_tank", 1], [20, "white_mini_boss", 1]],
	58: [[50, "purple_tank", 1], [5, "black_mini_boss", 1]],
	59: [[50, "yellow_mini_boss", 1], [45, "green_mini_boss", 1], [40, "blue_mini_boss", 1], [35, "grey_mini_boss", 1], [30, "white_mini_boss", 1], [25, "deep_blue_mini_boss", 1], [20, "black_mini_boss", 1], [1, "purple_mini_boss", 1]],
	60: [[1, "yellow_boss", 1]],
}
var gameUpgradesData = {
	"Cash": {
		1:{
			"type": "StartMoney",
			"text": "Starting Cash",
			"textValue": "Starting Cash: +150$",
			"value": 150,
			"has": false,
			"turned": false,
			"price": 1400,
			"previousHas" : true,
			"last": false
			},
		2:{
			"type": "CashPerWave",
			"text": "Cash per Wave up",
			"textValue": str(gameData["CashPerWave"]) + "x(wave) > " + str(gameData["CashPerWave"] + 2) + "xWave",
			"value": 2,
			"has": false,
			"turned": false,
			"price": 2700,
			"previousHas" : false,
			"last": true
			},
	},
	"Game":{
		1:{
			"type": "MaxSpeed",
			"text": "Speed Up Button",
			"value": 1.0,
			"textValue": str(gameData["MaxSpeed"]) + "x > " + str(gameData["MaxSpeed"] + 1) + "x",
			"has": false,
			"turned": false,
			"price": 800,
			"previousHas" : true,
			"last": true
			},
			
	},
	"Turret":{
		1:{
			"type": "DmgInc",
			"for": "bullet",
			"text": "Turret Bonus Damage",
			"value": 0.05,
			"textValue": "+5% Damage",
			"has": false,
			"turned": false,
			"price": 2000,
			"previousHas" : true,
			"last": true
			},
			
	},
	"Rocket":{
		1:{
			"type": "aoeMod",
			"for": "missle",
			"text": "Area of Effect Damage Cut Down",
			"value": 0.25,
			"textValue": str(bulletData["missle"]["aoeMod"] * 100) + "% > 75%",
			"has": false,
			"turned": false,
			"price": 3500,
			"previousHas" : true,
			"last": true
			},
			
	}
}

var shopData = {
	"turret": {
		"price": 150
	},
	"rocket": {
		"price": 250
	},
	"roadblock":{
		"price": 100
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"price": 200,
				"asup": -0.2,
				"dmgup": 10,
				"bulletspeedup": 50,
				"special": "Cannon Intergration"
			},
			2:{
				"price": 700,
				"asup": -0.3,
				"bulletspeedup": 100,
				"dmgup": 15,
				"special": "Advanced Hydraulics"
			},
			3:{
				"price": 2100,
				"dmgup": 20,
				"asup": -0.5,
				"special": "Improved Reload System"
			},
			4:{
				"price": 7200,
				"dmgup": 35,
				"rangup": 20,
				"bulletspeedup": 50,
				"special": "Rapidfire Double-Cannon"
			}
		},
		"p2": {
			1: {
				"price": 190,
				"rangeup": 20,
				"dmgup": 10,
				"special": "Front Lights"
			},
			2:{
				"price": 460,
				"rangeup": 40,
				"dmgup": 20,
				"special": "Cannon Nesting"
			},
			3:{
				"price": 2300,
				"rangeup": 120,
				"dmgup": 80,
				"asup": 1,
				"bulletspeedup": 150,
				"special": "Certifed MarksTower"
			},
			4:{
				"price": 12000,
				"rangeup": 200,
				"dmgup": 650,
				"asup": 2.5,
				"bulletspeedup": 550,
				"special": "Sniper Cosplay"
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
				"price": 410,
				"asup": -0.2,
				"dmgup": 15,
				"special": "Ammo reserve"
			},
			2:{
				"price": 680,
				"dmgup": 20,
				"asup": -0.3,
				"special": "Faster reload"
			},
			3:{
				"price": 2900,
				"asup": -0.5,
				"dmgup": 35,
				"bulletspeedup": 100,
				"special": "Futuristic Equipment"
			},
			4:{
				"price": 9500,
				"dmgup": 60,
				"asup": -2,
				"special": "Dual Rail"
			}
		},
		"p2": {
			1:{
				"price": 380,
				"rangeup": 30,
				"aoeup": 10,
				"dmgup": 5,
				"special": "More Explosive"
			},
			2:{
				"price": 810,
				"rangeup": 60,
				"aoeup": 10,
				"dmgup": 15,
				"special": "Higher capacity rockets"
			},
			3:{
				"price": 2900,
				"rangeup": 100,
				"aoeup": 20,
				"dmgup": 60,
				"angup": 40,
				"bulletspeedup": 200,
				"special": "Better Rockets"
			},
			4:{
				"price": 17500,
				"rangeup": 200,
				"aoeup": 60,
				"dmgup": 1200,
				"asup": 3.5,
				"bulletspeedup": 300,
				"special": "Long Range Nuke Delivery Service"
			}
		}
	},
	"roadblock": {
		"p1": {
			1: {
				"price": 200,
				"slowup": 0.02,
				"special": "Taller Bumper"
			},
			2:{
				"price": 320,
				"slowup": 0.03,
				"dmgup": 10,
				"special": "Higher Reach"
			},
			3:{
				"price": 1200,
				"slowup": 0.04,
				"dmgup": 15,
				"special": "Construction Sign"
			},
			4:{
				"price": 4100,
				"slowup": 0.06,
				"dmgup": 50,
				"pDmgup": 0.04,
				"special": "Laser Gate"
			}
		},
		"p2": {
			1: {
				"price": 220,
				"timeup": 2,
				"pDmgup": 0.005,
				"special": "Longer Bumper"
			},
			2:{
				"price": 340,
				"timeup": 3,
				"pDmgup": 0.01,
				"special": "XL Size"
			},
			3:{
				"price": 1800,
				"timeup": 4,
				"pDmgup": 0.03,
				"special": "Brick on a Road"
			},
			4:{
				"price": 3800,
				"timeup": 5,
				"pDmgup": 0.07,
				"special": "Zombie Apocalypse Road Block"
			}
		}
		
	},
	
}
