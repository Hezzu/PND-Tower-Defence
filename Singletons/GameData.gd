extends Node

var gameData = {
	"StartMoney": 450,
	"MaxSpeed": 2.0,
	"CashPerWave": 10,
	"WaveSkipRatio": 0.3,
	"Interest": 0.05,
}

var towerData = {
	"turret":{
		"dmg": 1,
		"dmgInc": 1,
		"range": 80,
		"as": 2,
		"angle": 200,
		"placement area": 32,
		"price": 250,
		"projectile": "bullet",
		"placement": "ground",
		"unlocked": true,
		},
	"rocket":{
		"dmg": 5,
		"range": 120,
		"as": 10,
		"angle": 280,
		"placement area": 21,
		"price": 350,
		"projectile": "missle",
		"placement": "ground",
		"unlocked": false,
		},
	"roadblock":{
		"dmg": 0,
		"pDmg": 0.005,
		"slow": 0.1,
		"time": 5,
		"price": 150,
		"placement": "road",
		"unlocked": false,
		}
}
var enemyData = { 
	"yellow":{
		"unit": "Yellow Tank",
		"type": "Normal",
		"speed": 30,
		"hp": 4,
		"UFGain": 0.5,
		"color": "ffff00",
	},
	"green":{
		"unit": "Green Tank",
		"type": "Normal",
		"speed": 40,
		"hp": 3,
		"UFGain": 1,
		"color": "4f7c00"
	},
	"blue":{
		"unit": "Blue Tank",
		"type": "Normal",
		"speed": 20,
		"hp": 18,
		"UFGain": 2,
		"color": "7571ff"
	},
	"grey":{
		"unit": "Grey Tank",
		"type": "Normal",
		"speed": 35,
		"hp": 30,
		"UFGain": 3,
		"color": "a9a9a9"
	},
	"brown":{
		"unit": "Brown Tank",
		"type": "Normal",
		"speed": 33,
		"hp": 50,
		"UFGain": 4,
		"color": "6f4600"
	},
	"green2":{
		"unit": "Dark Green Tank",
		"type": "Normal",
		"speed": 44,
		"hp": 16,
		"UFGain": 5,
		"color": "203b00"
	},
	"blue2":{
		"unit": "Dark Blue Tank",
		"type": "Normal",
		"speed": 28,
		"hp": 100,
		"UFGain": 6,
		"color": "0a009e"
	},
	"pink":{
		"unit": "Pink Tank",
		"type": "Normal",
		"speed": 42,
		"hp": 65,
		"UFGain": 7,
		"color": "ff4b82"
	},
	"yellowmb":{
		"unit": "Yellow Mini Boss",
		"type": "Miniboss",
		"speed": 20,
		"hp": 90,
		"UFGain": 15,
		"color": "cba700"
		
	},
	"greenmb":{
		"unit": "Green Mini Boss",
		"type": "Miniboss",
		"speed": 40,
		"hp": 180,
		"UFGain": 25,
		"color": "2d4a00"
	},
	"bluemb":{
		"unit": "Blue Mini Boss",
		"type": "Miniboss",
		"speed": 15,
		"hp": 980,
		"UFGain": 55,
		"color": "7571ff",
	},
	"greymb":{
		"unit": "Grey Mini Boss",
		"type": "Miniboss",
		"speed": 30,
		"hp": 1200,
		"UFGain": 70,
		"color": "6a6a6a"
	},
	"yellowb":{
		"unit": "Easy Boss",
		"type": "Boss",
		"speed": 10,
		"hp": 25000,
		"armor": 0.50,
		"UFGain": 1000,
		"color": "7e3500",
	},
#	End of Easy Mode
	"white":{
		"unit": "White Tank",
		"type": "Normal",
		"speed": 45,
		"hp": 280,
		"UFGain": 10,
		"color": "ffffff",
	},
	"black":{
		"unit": "Black Tank",
		"type": "Normal",
		"speed": 20,
		"hp": 1200,
		"armor": 0.75,
		"UFGain": 12,
		"color": "44484c"
	},
	"darkblue":{
		"unit": "Dark Blue Tank",
		"type": "Normal",
		"speed": 40,
		"hp": 480,
		"UFGain": 10,
		"color": "0234e4"
	},
	"purple":{
		"unit": "Purple Tank",
		"type": "Normal",
		"speed": 45,
		"hp": 540,
		"armor": 0.25,
		"UFGain": 15,
		"color": "8601c8"
	},
	"red":{
		"unit": "Red Tank",
		"type": "Normal",
		"speed": 50,
		"hp": 600,
		"armor": 0.5,
		"UFGain": 20,
		"color": "ff0000"
	},
	"redmb":{
		"unit": "Red Mini Boss",
		"type": "Miniboss",
		"speed": 20,
		"hp": 5000,
		"armor": 0.5,
		"UFGain": 200,
		"color": "b20000"
	},
	"whitemb":{
		"unit": "White Mini Boss",
		"type": "Miniboss",
		"speed": 28,
		"hp": 5000,
		"UFGain": 300,
		"color": "ffe2de"
	},
	"blackmb":{
		"unit": "Black Mini Boss",
		"type": "Miniboss",
		"speed": 15,
		"hp": 15000,
		"armor": 0.95,
		"UFGain": 500,
		"color": "2a2d2f"
	},
	"darkbluemb":{
		"unit": "Dark Blue Mini Boss",
		"type": "Miniboss",
		"speed": 18,
		"hp": 14000,
		"UFGain": 400,
		"color": "0122a7"
	},
	"purplemb":{
		"unit": "Purple Mini Boss",
		"type": "Miniboss",
		"speed": 20,
		"hp": 22000,
		"armor": 0.85,
		"UFGain": 800,
		"color": "600091"
	},
	"redb":{
		"unit": "Medium Boss",
		"type": "Boss",
		"speed": 15,
		"hp": 75000,
		"armor": 0.80,
		"UFGain": 2000,
		"color": "bf0057"
	}
}
var bulletData = {
	"bullet":{
		"speed": 250,
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
		"moneyMod": 1.3,
		"waves": 40,
		"waveHpMod": 0.9,
		"waveSpeedMod": 0.9,
		"priceMod": 0.8,
		"baseHealth": 150,
		"ufMulti": 0.3,
		"unlocked": true
	},
	"Med":{
		"moneyMod": 1.1,
		"waves": 60,
		"waveHpMod": 1.1,
		"waveSpeedMod": 1.1,
		"priceMod": 1,
		"baseHealth": 100,
		"ufMulti": 0.6,
		"unlocked": false
	},
	"Hard":{
		"moneyMod": 0.8,
		"waves": 60,
		"waveHpMod": 1.5,
		"waveSpeedMod": 1.5,
		"priceMod": 1.5,
		"baseHealth": 10,
		"ufMulti": 1,
		"unlocked": false
	},
	"Leg":{
		"moneyMod": 0.5,
		"waves": 60,
		"waveHpMod": 2,
		"waveSpeedMod": 2,
		"priceMod": 2,
		"baseHealth": 1,
		"ufMulti": 2,
		"unlocked": false
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
	42: [[10, "darkblue", 1], [5, "bluemb", 1], [35, "grey", 1]],
	43: [[15, "darkblue", 0.9], [5, "white", 2.5]],
	44: [[10, "white", 3], [3, "greymb", 5], [20, "darkblue", 1]],
	45: [[1, "whitemb", 1]],
	46: [[40, "darkblue", 1], [10, "white", 1], [1, "whitemb", 1]],
	47: [[5, "black", 2], [15, "white", 1], [45, "darkblue", 1]],
	48: [[10, "greymb", 1], [2, "whitemb", 2], [55, "darkblue", 1], [20, "white", 1]],
	49: [[60, "darkblue", 1], [30, "white", 1.5], [30, "black", 1], [10, "whitemb", 1]],
	50: [[1, "darkbluemb", 1]],
	51: [[20, "black", 1]],
	52: [[60, "darkblue", 1], [50, "white", 1], [25, "black", 1]],
	53: [[25, "whitemb", 1], [5, "purple", 1]],
	54: [[20, "purple", 1]],
	55: [[1, "blackmb", 1]],
	56: [[25, "purple", 1], [40, "white", 1], [15, "whitemb", 1], [1, "blackmb", 1]],
	57: [[30, "purple", 1], [20, "whitemb", 1]],
	58: [[50, "purple", 1], [5, "blackmb", 1]],
	59: [[50, "yellowmb", 1], [45, "greenmb", 1], [40, "bluemb", 1], [35, "greymb", 1], [30, "whitemb", 1], [25, "darkbluemb", 1], [20, "blackmb", 1], [1, "purplemb", 1]],
	60: [[1, "redb", 1]],
}
var gameUpgradesData = {
	"sc1":{
		"title": "Starting Cash 1",
		"info": "Increase the amount of money you start with by 50$",
		"price": 1400,
		"type": "SMU",
		"for": null,
		"value": 50,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": null,
		"exclusive": null,
	},
	"sc2":{
		"title": "Starting Cash 2",
		"info": "Increase the amount of money you start with by 100",
		"price": 2200,
		"type": "SMU",
		"for": null,
		"value": 100,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"sc1"
		],
		"exclusive": null,
	},
	"i1":{
		"title": "Interest Up 1",
		"info": "Increases the Interest % by 2%",
		"price": 6800,
		"type": "IU",
		"for": null,
		"value": 0.2,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"sc1"
		],
		"exclusive": null,
	},
	"cpw1":{
		"title": "Cash Per Wave Up 1",
		"info": "Increases the money you get per wave by 2x Wave",
		"price": 4500,
		"type": "CPWU",
		"for": null,
		"value": 2,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"sc1"
		],
		"exclusive": null,
	},
	"gdu1":{
		"title": "Tower Upgrades",
		"info": "Unlocks the Tower Upgrades",
		"price": 300,
		"type": "Other",
		"for": null,
		"value": null,
		"bought": false,
		"enabled": false,
		"oneshot": true,
		"requirements": null,
		"exclusive": null,
	},
	"bd1": {
		"title": "roadBlock Base Damage Up 1",
		"info": "Increases Base Damage of Roadblock by 1",
		"price": 15000,
		"type": "StatBuff",
		"for": ["tower", "roadblock", "dmg"],
		"value": 1,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"gdu1",
			"bu"
		],
		"exclusive": null,
	},
	"am1":{
		"title": "Area of Effect Cut Down 1",
		"info": "Decreased the Area of Effect Damage Cut by 25%",
		"price": 10000,
		"type": "StatBuff",
		"for": ["bullet", "missle", "aoeMod"],
		"value": 0.25,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"gdu1",
			"ru"
		],
		"exclusive": null,
	},
	"pdu1":{
		"title": "Turret Damage Up 1",
		"info": "Increase the Damage of the Turret by 5%",
		"price": 3400,
		"type": "StatBuff",
		"for": ["tower", "turret", "dmgInc"],
		"value": 0.05,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"gdu1"
		],
		"exclusive": null,
	},
	"gsu1":{
		"title": "Speed Up 1",
		"info": "Max Speed up Increased to 3x",
		"price": 500,
		"type": "MS",
		"for": null,
		"value": 1.0,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": null,
		"exclusive": [
			"MS"
		],
	},
	"gsu2":{
		"title": "Speed Up 2",
		"info": "Max Speed up Increased to 4x",
		"price": 1300,
		"type": "MS",
		"for": null,
		"value": 2.0,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"gsu1"
		],
		"exclusive": [
			"MS"
		],
	},
	"sru1":{
		"title": "Skip Wave Ratio Up 1",
		"info": "Increase the wave total hp% left to skip a wave to 70%",
		"price": 2200,
		"type": "SRU",
		"for": null,
		"value": 0.4,
		"bought": false,
		"enabled": false,
		"oneshot": false,
		"requirements": [
			"gsu1"
		],
		"exclusive": [
			"SRU"
		],
	},
	"nmu":{
		"title": "Unlock normal mode",
		"info": "Unlocks normal mode difficulty",
		"price": 800,
		"type": "Unlock",
		"for": ["diff", "Med"],
		"value": null,
		"bought": false,
		"enabled": false,
		"oneshot": true,
		"requirements": null,
		"exclusive": null,
	},
	"bu":{
		"title": "Unlock Roadblock",
		"info": "Unlocks the Roadblock tower",
		"price": 1000,
		"type": "Unlock",
		"for": ["tower", "roadblock"],
		"value": null,
		"bought": false,
		"enabled": false,
		"oneshot": true,
		"requirements": [
			"ru"
		],
		"exclusive": null,
	},
	"ru":{
		"title": "Unlock Rocket Tower",
		"info": "Unlocks the Rocket Tower",
		"price": 1800,
		"type": "Unlock",
		"for": ["tower", "rocket"],
		"value": null,
		"bought": false,
		"enabled": false,
		"oneshot": true,
		"requirements": [
			"nmu"
		],
		"exclusive": null,
	},
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
				"Damage": 1,
				"Attack Speed": -0.3,
				"price": 440,
			},
			3:{
				"Name": "Improved Reloading",
				"Damage": 5,
				"Attack Speed": -0.5,
				"price": 3000,
			},
			4:{
				"Name": "Rapidfire Dual-Cannon",
				"Damage": 27,
				"Range": 20,
				"Bullet Speed": 50,
				"price": 8400,
			}
		},
		"p2": {
			1: {
				"Name": "Front Lights",
				"Range": 20,
				"Bullet Speed": 50,
				"price": 240,
			},
			2:{
				"Name": "Cannon Nesting",
				"Range": 30,
				"Angle": 20,
				"Bullet Speed": 100,
				"price": 460,
			},
			3:{
				"Name": "Certifed MarksTower",
				"Damage": 37,
				"Range": 60,
				"Angle": 40,
				"Attack Speed": 1.5,
				"Bullet Speed": 150,
				"price": 2800,
			},
			4:{
				"Name": "Sniper Cosplay",
				"Damage": 210,
				"Range": 200,
				"Attack Speed": 2,
				"Bullet Speed": 550,
				"price": 6900,
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
				"Name": "Ammo reserve",
				"Damage": 2,
				"Attack Speed": -0.2,
				"price": 300,
			},
			2:{
				"Name": "Faster reload",
				"Damage": 3,
				"Attack Speed": -0.3,
				"price": 600,
			},
			3:{
				"Name": "Futuristic Equipment",
				"Damage": 10,
				"Attack Speed": -1.5,
				"Bullet Speed": 100,
				"price": 2600,
			},
			4:{
				"Name": "Dual Rail",
				"Damage": 40,
				"Attack Speed": -2.5,
				"price": 8500,
			}
		},
		"p2": {
			1:{
				"Name": "More Explosive",
				"Range": 30,
				"Area of Effect": 10,
				"price": 250,
			},
			2:{
				"Name": "Higher Capacity",
				"Range": 60,
				"Angle": 10,
				"Area of Effect": 20,
				"price": 600,
			},
			3:{
				"Name": "Better Rockets",
				"Damage": 120,
				"Range": 180,
				"Angle": 20,
				"Attack Speed": 3,
				"Area of Effect": 40,
				"Bullet Speed": 200,
				"price": 4700,
			},
			4:{
				"Name": "L.R.N.D.S",
				"Damage": 1650,
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
				"Percentage Damage": 0.01,
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
				"Slow Time": 10,
				"Slow Amount": 0.1,
				"Percentage Damage": 0.05,
				"price": 4500,
			}
		}
		
	},
	
}
