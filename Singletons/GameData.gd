extends Node

var towerData = {
	"turret":{
		"dmg": 30,
		"range": 100,
		"as": 2,
		"angle": 260,
		"placement area": 32,
		"projectile": "bullet",
		"set": "Set1",
		"placement": "ground",
		},
	"rocket":{
		"dmg": 85,
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
		"pDmg": 0.01,
		"slow": 0.1,
		"time": 2,
		"set": "Set2",
		"placement": "road",
		}
}
var enemyData = {
	"bluetank":{
		"speed": 30,
		"hp": 70,
		"base_dmg": 1,
		"KillGold": 3,
		"UFGain": 0.5
	},
	"greentank":{
		"speed": 35,
		"hp": 120,
		"base_dmg": 5,
		"KillGold": 5,
		"UFGain": 1
	},
	"whitetank":{
		"speed": 45,
		"hp": 260,
		"base_dmg": 10,
		"KillGold": 8,
		"UFGain": 1.5,
	},
	"redtank":{
		"speed": 40,
		"hp": 400,
		"base_dmg": 15,
		"KillGold": 10,
		"UFGain": 2.5
	},
	"redminiboss":{
		"speed": 20,
		"hp": 2300,
		"base_dmg": 95,
		"KillGold": 250,
		"UFGain": 20
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

var waveData = {
#	1: [[1, "red_boss", 1]],
	1: [[4, "blue_tank", 1]],
	2: [[6, "blue_tank", 1]],
	3: [[8, "blue_tank", 0.7]],
	4: [[8, "blue_tank", 0.5]],
	5: [[12, "blue_tank", 0.5]],
	6: [[8, "blue_tank", 0.8], [2, "green_tank", 1.5]],
	7: [[10, "blue_tank", 0.8], [4, "green_tank", 1.3]],
	8: [[15, "blue_tank", 1], [1, "blue_tank", 2.5], [4, "green_tank", 1]],
	9: [[15, "blue_tank", 1], [1, "blue_tank", 4], [20, "blue_tank", 0.8], [1, "blue_tank", 1.5], [2, "green_tank", 1.2]],
	10: [[12, "blue_tank", 0.5], [3, "blue_tank", 1.3], [6, "green_tank", 1]],
	11: [[6, "blue_tank", 0.7], [8, "green_tank", 1]],
	12: [[8, "blue_tank", 0.5], [14, "green_tank", 1]],
	13: [[10, "blue_tank", 0.3], [1, "green_tank", 2], [9, "green_tank", 1]],
	14: [[30, "blue_tank", 0.5], [15, "green_tank", 1]],
	15: [[10, "blue_tank", 1.5], [10, "blue_tank", 1], [10, "blue_tank", 0.7], [10, "blue_tank", 0.3], [10, "green_tank", 1], [7, "green_tank", 0.7], [5, "green_tank", 0.5]],
	16: [[15, "green_tank", 1], [10, "green_tank", 0.5]],
	17: [[30, "green_tank", 0.7]],
	18: [[15, "green_tank", 1.5], [4, "white_tank", 2]],
	19: [[15, "green_tank", 1.3], [15, "green_tank", 1], [15, "green_tank", 0.7], [15, "green_tank", 0.5]],
	20: [[1, "red_mini_boss", 1]],
	21: [[10, "white_tank", 1]],
	22: [[20, "white_tank", 1]],
	23: [[20, "white_tank", 1], [10, "white_tank", 0.7]],
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
var gameUpgradesData = {
	"StartingCash": {
		"text": "Starting Cash",
		"textValue": "+150$",
		"value": 150,
		"has": false,
		"price": 700
	},
	"CashMultiUp": {
		"text": "Cash per Wave up",
		"textValue": "14x(wave)>16x(wave)",
		"value": 16,
		"has": false,
		"price": 1400
	}
}

var shopData = {
	"turret": {
		"price": 140
	},
	"rocket": {
		"price": 260
	},
	"roadblock":{
		"price": 80
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"price": 280,
				"asup": -0.3,
				"dmgup": 5,
				"bulletspeedup": 50,
				"special": "Cannon Intergration"
			},
			2:{
				"price": 750,
				"asup": -0.4,
				"bulletspeedup": 100,
				"dmgup": 15,
				"special": "Advanced Hydraulics"
			},
			3:{
				"price": 1900,
				"dmgup": 15,
				"asup": -0.5,
				"special": "Improved Reload System"
			},
			4:{
				"price": 6100,
				"dmgup": 10,
				"rangup": 20,
				"bulletspeedup": 50,
				"special": "Rapidfire Double-Cannon"
			}
		},
		"p2": {
			1: {
				"price": 210,
				"rangeup": 20,
				"dmgup": 10,
				"special": "Front Lights"
			},
			2:{
				"price": 590,
				"rangeup": 40,
				"dmgup": 15,
				"special": "Cannon Nesting"
			},
			3:{
				"price": 2100,
				"rangeup": 120,
				"dmgup": 100,
				"bulletspeedup": 150,
				"special": "Certifed MarksTower"
			},
			4:{
				"price": 4500,
				"rangeup": 200,
				"dmgup": 450,
				"asup": 1.7,
				"special": "Sniper Cosplay"
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
				"price": 450,
				"asup": -0.2,
				"dmgup": 15,
				"special": "Ammo reserve"
			},
			2:{
				"price": 820,
				"dmgup": 20,
				"asup": -0.3,
				"special": "Faster reload"
			},
			3:{
				"price": 3000,
				"asup": -1.5,
				"dmgup": 25,
				"bulletspeedup": 100,
				"special": "Futuristic Equipment"
			},
			4:{
				"price": 6800,
				"dmgup": 30,
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
				"price":850,
				"rangeup": 60,
				"aoeup": 20,
				"dmgup": 15,
				"special": "Higher capacity rockets"
			},
			3:{
				"price": 2500,
				"rangeup": 100,
				"aoeup": 40,
				"dmgup": 80,
				"special": "Better Rockets"
			},
			4:{
				"price": 7200,
				"rangeup": 150,
				"aoeup": 60,
				"dmgup": 250,
				"angup": 40,
				"bulletspeedup": 200,
				"special": "Long Range Nuke Delivery Service"
			}
		}
	},
	"roadblock": {
		"p1": {
			1: {
				"price": 120,
				"slowup": 0.05,
				"dmgup": 5,
				"pDmgup": 0.01,
				"special": "Taller Bumper"
			},
			2:{
				"price": 190,
				"slowup": 0.1,
				"dmgup": 5,
				"pDmgup": 0.02,
				"special": "More Curvy"
			},
			3:{
				"price": 1000,
				"slowup": 0.10,
				"dmgup": 5,
				"pDmgup": 0.03,
				"special": "Construction Sign"
			},
			4:{
				"price": 3000,
				"slowup": 0.1,
				"dmgup": 10,
				"pDmgup": 0.05,
				"special": "Laser Gate"
			}
		},
		"p2": {
			1: {
				"price": 90,
				"timeup": 1,
				"pDmgup": 0.01,
				"special": "Longer Bumper"
			},
			2:{
				"price": 170,
				"timeup": 2,
				"pDmgup": 0.02,
				"special": "XL Size"
			},
			3:{
				"price": 600,
				"timeup": 3,
				"pDmgup": 0.6,
				"special": "Brick on Road"
			},
			4:{
				"price": 4100,
				"timeup": 6,
				"pDmgup": 0.1,
				"dmg": 40,
				"special": "Zombie Apocalypse Road Block"
			}
		}
		
	},
	
}
