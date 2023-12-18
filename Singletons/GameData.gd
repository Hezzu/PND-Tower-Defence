extends Node

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
		"hp": 1500,
		"armor": 0.95,
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
		"UFGain": 25
	},
	"blackminiboss":{
		"speed": 10,
		"hp": 50000,
		"armor": 0.8,
		"base_dmg": 100,
		"KillGold": 800,
		"UFGain": 50
	},
	"deepblueminiboss":{
		"speed": 18,
		"hp": 20000,
		"base_dmg": 100,
		"KillGold": 500,
		"UFGain": 35
	},
	"purpleminiboss":{
		"speed": 20,
		"hp": 150000,
		"armor": 0.8,
		"base_dmg": 250,
		"KillGold": 1500,
		"UFGain": 100
	},
	"yellowboss":{
		"speed": 10,
		"hp": 600000,
		"armor": 0.7,
		"base_dmg": 999,
		"KillGold": 2000,
		"UFGain": 500
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
	},
	"missle":{
		"speed": 600,
		"aoe": 30
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
		"moneyMod": 1,
		"waves": 40,
		"waveHpMod": 0.02,
		"waveSpeedMod": 0.05,
		"priceMod": 1,
		"baseHealth": 100,
		"ufMulti": 1
	},
	"Med":{
		"moneyMod": 0.9,
		"waves": 60,
		"waveHpMod": 0.03,
		"waveSpeedMod": 0.06,
		"priceMod": 1.1,
		"baseHealth": 50,
		"ufMulti": 2
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
			"text": "Starting Cash",
			"textValue": "+150$",
			"value": 150,
			"has": false,
			"price": 700,
			"previousHas" : true,
			"last": false
			},
		2:{
			"text": "Cash per Wave up",
			"textValue": "12x(wave)>14x(wave)",
			"value": 14,
			"has": false,
			"price": 1400,
			"previousHas" : false,
			"last": true
			},
	},
	"Game":{
		1:{
			"text": "Speed Up Button",
			"textValue": "2x > 3x",
			"value": 3.0,
			"has": false,
			"price": 400,
			"previousHas" : true,
			"last": true
			},
			
	}
}

var shopData = {
	"turret": {
		"price": 120
	},
	"rocket": {
		"price": 220
	},
	"roadblock":{
		"price": 50
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"price": 160,
				"asup": -0.2,
				"dmgup": 5,
				"bulletspeedup": 50,
				"special": "Cannon Intergration"
			},
			2:{
				"price": 650,
				"asup": -0.3,
				"bulletspeedup": 100,
				"dmgup": 10,
				"special": "Advanced Hydraulics"
			},
			3:{
				"price": 1700,
				"dmgup": 10,
				"asup": -0.5,
				"special": "Improved Reload System"
			},
			4:{
				"price": 5900,
				"dmgup": 15,
				"rangup": 20,
				"bulletspeedup": 50,
				"special": "Rapidfire Double-Cannon"
			}
		},
		"p2": {
			1: {
				"price": 140,
				"rangeup": 20,
				"dmgup": 10,
				"special": "Front Lights"
			},
			2:{
				"price": 420,
				"rangeup": 40,
				"dmgup": 15,
				"special": "Cannon Nesting"
			},
			3:{
				"price": 2000,
				"rangeup": 120,
				"dmgup": 100,
				"bulletspeedup": 150,
				"special": "Certifed MarksTower"
			},
			4:{
				"price": 6000,
				"rangeup": 200,
				"dmgup": 450,
				"asup": 1.5,
				"special": "Sniper Cosplay"
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
				"price": 350,
				"asup": -0.2,
				"dmgup": 15,
				"special": "Ammo reserve"
			},
			2:{
				"price": 620,
				"dmgup": 20,
				"asup": -0.3,
				"special": "Faster reload"
			},
			3:{
				"price": 2400,
				"asup": -0.5,
				"dmgup": 30,
				"bulletspeedup": 100,
				"special": "Futuristic Equipment"
			},
			4:{
				"price": 6800,
				"dmgup": 30,
				"asup": -1,
				"special": "Dual Rail"
			}
		},
		"p2": {
			1:{
				"price": 350,
				"rangeup": 40,
				"aoeup": 10,
				"dmgup": 10,
				"special": "More Explosive"
			},
			2:{
				"price":750,
				"rangeup": 60,
				"aoeup": 20,
				"dmgup": 15,
				"special": "Higher capacity rockets"
			},
			3:{
				"price": 2500,
				"rangeup": 100,
				"aoeup": 30,
				"dmgup": 60,
				"special": "Better Rockets"
			},
			4:{
				"price": 15500,
				"rangeup": 200,
				"aoeup": 80,
				"dmgup": 350,
				"angup": 40,
				"bulletspeedup": 200,
				"special": "Long Range Nuke Delivery Service"
			}
		}
	},
	"roadblock": {
		"p1": {
			1: {
				"price": 200,
				"slowup": 0.05,
				"dmgup": 5,
				"special": "Taller Bumper"
			},
			2:{
				"price": 320,
				"slowup": 0.1,
				"dmgup": 10,
				"special": "Higher Reach"
			},
			3:{
				"price": 1600,
				"slowup": 0.15,
				"dmgup": 15,
				"special": "Construction Sign"
			},
			4:{
				"price": 4100,
				"slowup": 0.20,
				"dmgup": 50,
				"pDmgup": 0.1,
				"special": "Laser Gate"
			}
		},
		"p2": {
			1: {
				"price": 220,
				"timeup": 1,
				"pDmgup": 0.005,
				"special": "Longer Bumper"
			},
			2:{
				"price": 340,
				"timeup": 2,
				"pDmgup": 0.01,
				"special": "XL Size"
			},
			3:{
				"price": 1800,
				"timeup": 3,
				"pDmgup": 0.1,
				"special": "Brick on a Road"
			},
			4:{
				"price": 3800,
				"timeup": 5,
				"pDmgup": 0.18,
				"dmgup": 10,
				"special": "Zombie Apocalypse Road Block"
			}
		}
		
	},
	
}
