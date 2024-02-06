extends Node

var gameData = {
	"StartMoney": 450,
	"MaxSpeed": 2.0,
	"CashPerWave": 10
}


var towerData = {
	"turret":{
		"dmg": 1,
		"range": 80,
		"as": 2,
		"angle": 200,
		"placement area": 32,
		"projectile": "bullet",
		"set": "Set1",
		"placement": "ground",
		},
	"rocket":{
		"dmg": 5,
		"range": 140,
		"as": 8,
		"angle": 280,
		"placement area": 21,
		"projectile": "missle",
		"set": "Set1",
		"placement": "ground",
		},
	"roadblock":{
		"dmg": 0,
		"pDmg": 0.005,
		"slow": 0.1,
		"time": 5,
		"set": "Set2",
		"placement": "road",
		}
}
var enemyData = { 
	"yellow":{
		"unit": "Yellow Tank",
		"speed": 30,
		"hp": 4,
		"UFGain": 1,
		"color": "ffff00",
	},
	"green":{
		"unit": "Green Tank",
		"speed": 40,
		"hp": 3,
		"UFGain": 2,
		"color": "4f7c00"
	},
	"blue":{
		"unit": "Blue Tank",
		"speed": 20,
		"hp": 15,
		"UFGain": 3,
		"color": "7571ff"
	},
	"grey":{
		"unit": "Grey Tank",
		"speed": 35,
		"hp": 40,
		"UFGain": 5,
		"color": "a9a9a9"
	},
	"brown":{
		"unit": "Brown Tank",
		"speed": 35,
		"hp": 50,
		"UFGain": 5,
		"color": "6f4600"
	},
	"green2":{
		"unit": "Dark Green Tank",
		"speed": 45,
		"hp": 15,
		"UFGain": 5,
		"color": "203b00"
	},
	"blue2":{
		"unit": "Dark Blue Tank",
		"speed": 25,
		"hp": 120,
		"UFGain": 10,
		"color": "0a009e"
	},
	"pink":{
		"unit": "Pink Tank",
		"speed": 40,
		"hp": 70,
		"UFGain": 10,
		"color": "ff4b82"
	},
	"yellowmb":{
		"unit": "Yellow Mini Boss",
		"speed": 15,
		"hp": 150,
		"UFGain": 50,
		"color": "cba700"
		
	},
	"greenmb":{
		"unit": "Green Mini Boss",
		"speed": 40,
		"hp": 400,
		"UFGain": 100,
		"color": "2d4a00"
	},
	"bluemb":{
		"unit": "Blue Mini Boss",
		"speed": 12,
		"hp": 1200,
		"UFGain": 150,
		"color": "7571ff",
	},
	"greymb":{
		"unit": "Grey Mini Boss",
		"speed": 30,
		"hp": 1800,
		"UFGain": 200,
		"color": "6a6a6a"
	},
	"yellowb":{
		"unit": "Tank Boss",
		"speed": 5,
		"hp": 35000,
		"armor": 0.75,
		"UFGain": 500,
		"color": "7e3500",
	},
#	End of Easy Mode
	"whitetank":{
		"speed": 45,
		"hp": 280,
		"base_dmg": 10,
		"UFGain": 6
	},
	"blacktank":{
		"speed": 20,
		"hp": 1200,
		"armor": 0.93,
		"base_dmg": 30,
		"UFGain": 8,
	},
	"deepbluetank":{
		"speed": 40,
		"hp": 480,
		"base_dmg": 15,
		"UFGain": 10,
	},
	"purpletank":{
		"speed": 45,
		"hp": 540,
		"armor": 0.9,
		"base_dmg": 20,
		"UFGain": 12,
	},
	"redtank":{
		"speed": 50,
		"hp": 500,
		"base_dmg": 25,
		"UFGain": 20
	},
	"redminiboss":{
		"speed": 20,
		"hp": 2300,
		"base_dmg": 95,
		"UFGain": 100
	},
	"whiteminiboss":{
		"speed": 25,
		"hp": 1600,
		"base_dmg": 100,
		"UFGain": 100
	},
	"blackminiboss":{
		"speed": 10,
		"hp": 40000,
		"armor": 0.8,
		"base_dmg": 100,
		"UFGain": 250
	},
	"deepblueminiboss":{
		"speed": 18,
		"hp": 14000,
		"base_dmg": 100,
		"UFGain": 200
	},
	"purpleminiboss":{
		"speed": 20,
		"hp": 22000,
		"armor": 0.85,
		"base_dmg": 250,
		"UFGain": 800
	},
	"redboss":{
		"speed": 8,
		"hp": 38000,
		"base_dmg": 100,
		"UFGain": 1000
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

var diffData = {
	"Easy":{
		"moneyMod": 1.1,
		"waves": 40,
		"waveHpMod": 1,
		"waveSpeedMod": 1,
		"priceMod": 0.9,
		"baseHealth": 150,
		"ufMulti": 0.5
	},
	"Med":{
		"moneyMod": 1,
		"waves": 40,
		"waveHpMod": 1.5,
		"waveSpeedMod": 1.5,
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
	1: [[4, "yellow", 2.2]],
	2: [[6, "yellow", 2.2]],
	3: [[10, "yellow", 2.2]],
	4: [[11, "yellow", 2.2], [1, "yellow", 6], [4, "green", 1.8]],
	5: [[8, "green", 1.8]],
	6: [[12, "yellow", 2.2], [6, "green", 1.8]],
	7: [[18, "yellow", 2.2], [8, "green", 1.8]],
	8: [[6, "blue", 3.2]],
	9: [[19, "yellow", 2.2],[1, "yellow", 6], [12, "green", 1.7], [2, "blue", 3.2]],
	10: [[1, "yellowmb", 1]],
	11: [[23, "yellow", 2.2], [1, "yellow", 6], [14, "green", 1.7]],
	12: [[17, "green", 1.8], [1, "green", 6], [25, "yellow", 2.2], [1, "yellow", 8], [4, "blue", 3.2]],
	13: [[36, "yellow", 3], [8, "blue", 3.2]],
	14: [[39, "yellow", 2.2], [1, "yellow", 6], [20, "green", 1.7]],
	15: [[17, "green", 1.7], [1, "green", 8], [16, "blue", 3.2]],
	16: [[3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3], [3, "yellow", 2.2], [1, "yellow", 4], [3, "green", 1.7], [1, "green", 3]],
	17: [[22, "blue", 3.2]],
	18: [[6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2], [6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2], [6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2], [6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2], [6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2], [6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2], [6, "green", 1.7], [4, "yellow", 2.2], [2, "blue", 3.2]],
	19: [[40, "green", 1.7], [2, "yellowmb", 7]],
	20: [[1, "greenmb", 1]],
	21: [[6, "grey", 1.9]],
	22: [[14, "blue", 3.2], [6, "grey", 1.9]],
	23: [[10, "grey", 1.9], [20, "green", 1.7], [6, "grey", 1.9]],
	24: [[12, "grey", 1.9], [12, "blue", 3.2], [24, "green", 1.9]],
	25: [[8, "grey", 1.9], [4, "brown", 1.9]],
	26: [[12, "grey", 1.9], [16, "green", 1.7], [6, "brown", 1.9]],
	27: [[12, "brown", 1.9], [2, "green2", 1.5]],
	28: [[8, "green2", 1.5]],
	29: [[1, "yellowmb", 12], [4, "blue2", 3]],
	30: [[1, "bluemb", 1]],
	31: [[16, "brown", 1.9], [6, "green2", 1.5]],
	32: [[12, "green2", 1.5], [6, "blue2", 3]],
	33: [[29, "green", 1.7], [1, "green", 4], [11, "green2", 1.5], [1, "green2", 5], [2, "greenmb", 4.5]],
	34: [[19, "blue", 3.2], [1, "blue", 5], [10, "blue2", 3], [2, "bluemb", 10]],
	35: [[1, "greymb", 1]],
	36: [[17, "brown", 1.9], [1, "brown", 6], [4, "pink", 1.7]],
	37: [[10, "pink", 1.7]],
	38: [[39, "yellow", 2.2], [1, "yellow", 4], [34, "green", 1.7], [1, "green", 4], [29, "blue", 3.2], [1, "blue", 5], [24, "grey", 1.9], [1, "grey", 5], [19, "brown", 1.9], [1, "brown", 4], [14, "green2", 1.5], [1, "green2", 5], [9, "blue2", 3], [1, "blue2", 8], [5, "pink", 1.7]],
	39: [[20, "yellowmb", 7], [15, "greenmb", 5], [10, "bluemb", 12]],
	40: [[1, "yellowb", 1]],
#Easy Mode End
	41: [[15, "pink", 1.7], [25, "grey", 1]],
	42: [[10, "deep_blue_tank", 1], [5, "bluemb", 1], [35, "grey", 1]],
	43: [[15, "deep_blue_tank", 0.9], [5, "white_tank", 2.5]],
	44: [[10, "white_tank", 3], [3, "greymb", 5], [20, "deep_blue_tank", 1]],
	45: [[1, "white_mini_boss", 1]],
	46: [[40, "deep_blue_tank", 1], [10, "white_tank", 1], [1, "white_mini_boss", 1]],
	47: [[5, "black_tank", 2], [15, "white_tank", 1], [45, "deep_blue_tank", 1]],
	48: [[10, "greymb", 1], [2, "white_mini_boss", 2], [55, "deep_blue_tank", 1], [20, "white_tank", 1]],
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
	59: [[50, "yellowmb", 1], [45, "greenmb", 1], [40, "bluemb", 1], [35, "greymb", 1], [30, "white_mini_boss", 1], [25, "deep_blue_mini_boss", 1], [20, "black_mini_boss", 1], [1, "purple_mini_boss", 1]],
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
			"textValue": str(bulletData["missle"]["aoeMod"] * 100) + "% > " + str((bulletData["missle"]["aoeMod"] + 0.25) * 100) + "%",
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
		"price": 250
	},
	"rocket": {
		"price": 350
	},
	"roadblock":{
		"price": 100
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"Name": "Cannon Intergration",
				"Damage": 1,
				"Attack Speed": -0.2,
				"price": 320,
				
			},
			2:{
				"Name": "Advanced Hydraulics",
				"Damage": 3,
				"Attack Speed": -0.3,
				"price": 700,
			},
			3:{
				"Name": "Imporved Reloading",
				"Damage": 10,
				"Attack Speed": -0.5,
				"price": 3600,
			},
			4:{
				"Name": "Rapidfire Dual-Cannon",
				"Damage": 35,
				"Range": 20,
				"Bullet Speed": 50,
				"price": 7400,
			}
		},
		"p2": {
			1: {
				"Name": "Front Lights",
				"Range": 20,
				"Bullet Speed": 50,
				"price": 280,
			},
			2:{
				"Name": "Cannon Nesting",
				"Range": 30,
				"Angle": 20,
				"Bullet Speed": 100,
				"price": 660,
			},
			3:{
				"Name": "Certifed MarksTower",
				"Damage": 35,
				"Range": 60,
				"Angle": 40,
				"Attack Speed": 2,
				"Bullet Speed": 150,
				"price": 2800,
			},
			4:{
				"Name": "Sniper Cosplay",
				"Damage": 80,
				"Range": 200,
				"Attack Speed": 2.5,
				"Bullet Speed": 550,
				"price": 9000,
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
				"Name": "Ammo reserve",
				"Damage": 5,
				"Attack Speed": -0.3,
				"price": 400,
			},
			2:{
				"Name": "Faster reload",
				"Damage": 10,
				"Attack Speed": -0.7,
				"price": 800,
			},
			3:{
				"Name": "Futuristic Equipment",
				"Damage": 20,
				"Attack Speed": -1.5,
				"Bullet Speed": 100,
				"price": 1400,
			},
			4:{
				"Name": "Dual Rail",
				"Damage": 60,
				"Attack Speed": -2.5,
				"price": 9500,
			}
		},
		"p2": {
			1:{
				"Name": "More Explosive",
				"Range": 30,
				"Area of Effect": 20,
				"price": 250,
			},
			2:{
				"Name": "Higher Capacity",
				"Range": 60,
				"Angle": 10,
				"Area of Effect": 30,
				"price": 600,
			},
			3:{
				"Name": "Better Rockets",
				"Damage": 130,
				"Range": 200,
				"Angle": 20,
				"Attack Speed": 3,
				"Area of Effect": 50,
				"Bullet Speed": 200,
				"price": 4700,
			},
			4:{
				"Name": "L.R.N.D.S",
				"Damage": 1850,
				"Range": 300,
				"Angle": 30,
				"Attack Speed": 10,
				"Area of Effect": 150,
				"Bullet Speed": 400,
				
				"price": 17500,
			}
		}
	},
	"roadblock": {
		"p1": {
			1: {
				"Name": "Taller Bumper",
				"Slow Amount": 0.1,
				"price": 100,
			},
			2:{
				"Name": "Higher Reach",
				"Damage": 1,
				"price": 300,
				
			},
			3:{
				"Name": "Construction Sign",
				"Damage": 2,
				"Slow Amount": 0.1,
				"price": 1500,
			},
			4:{
				"Name": "Laser Gate",
				"Damage": 3,
				"Slow Amount": 0.1,
				"Percentage Damage": 0.03,
				"price": 4100,
			}
		},
		"p2": {
			1: {
				"Name": "Longer Bumper",
				"Slow Time": 2,
				"Percentage Damage": 0.005,
				"price": 150,
			},
			2:{
				"Name": "XL Size",
				"Slow Time": 3,
				"Percentage Damage": 0.01,
				"price": 340,
			},
			3:{
				"Name": "Brick on a Road",
				"Slow Time": 5,
				"Percentage Damage": 0.03,
				"price": 1800,
			},
			4:{
				"Name": "Road Block from Hell",
				"Slow Time": 6,
				"Percentage Damage": 0.1,
				"price": 4500,
			}
		}
		
	},
	
}
