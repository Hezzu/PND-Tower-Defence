extends Node

var towerData = {
	"turret":{
		"dmg": 30,
		"range": 120,
		"as": 2,
		"angle": 260,
		"placement area": 40,
		"projectile": "bullet",
		},
	"rocket":{
		"dmg": 85,
		"range": 200,
		"as": 5,
		"angle": 320,
		"placement area": 35,
		"projectile": "missle",
		}
}
var enemyData = {
	"bluetank":{
		"speed": 40,
		"hp": 70,
		"base_dmg": 1,
		"KillGold": 2,
		"UFGain": 0.5
	},
	"greentank":{
		"speed": 50,
		"hp": 120,
		"base_dmg": 5,
		"KillGold": 4,
		"UFGain": 1
	},
	"whitetank":{
		"speed": 60,
		"hp": 310,
		"base_dmg": 10,
		"KillGold": 6,
		"UFGain": 1.5,
	},
	"redtank":{
		"speed": 55,
		"hp": 440,
		"base_dmg": 15,
		"KillGold": 8,
		"UFGain": 2.5
	},
	"redminiboss":{
		"speed": 25,
		"hp": 2100,
		"base_dmg": 95,
		"KillGold": 100,
		"UFGain": 20
	},
	"redboss":{
		"speed": 10,
		"hp": 40000,
		"base_dmg": 100,
		"KillGold": 300,
		"UFGain": 100
	}
}
var bulletData = {
	"bullet":{
		"speed": 250,
	},
	"missle":{
		"speed": 600,
		"aoe": 50
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
		"value": 150,
		"has": false
	}
}

var shopData = {
	"turret": {
		"price": 150
	},
	"rocket": {
		"price": 270
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"price": 320,
				"asup": -0.2,
				"dmgup": 5,
				"bulletspeedup": 50
			},
			2:{
				"price": 820,
				"asup": -0.3,
				"bulletspeedup": 100,
				"dmgup": 15
			},
			3:{
				"price": 2000,
				"dmgup": 15,
				"asup": -0.5,
				"special": "Improved Reload System"
			},
			4:{
				"price": 5400,
				"dmgup": 20,
				"rangup": 20,
				"bulletspeedup": 50,
				"special": "Rapidfire Cannon"
			}
		},
		"p2": {
			1: {
				"price": 250,
				"rangeup": 20,
				"dmgup": 10
			},
			2:{
				"price": 630,
				"rangeup": 40,
				"dmgup": 15,
			},
			3:{
				"price": 2200,
				"rangeup": 120,
				"dmgup": 100,
				"bulletspeedup": 150,
				"special": "Certifed MarksTower"
			},
			4:{
				"price": 4100,
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
			"price": 550,
			"asup": -0.2,
			"dmgup": 15
			},
			2:{
				"price": 920,
				"dmgup": 20,
				"asup": -0.3
			},
			3:{
				"price": 3200,
				"asup": -1.5,
				"dmgup": 25,
				"bulletspeedup": 100,
				"special": "Rapid Fire"
			},
			4:{
				"price": 6700,
				"dmgup": 30,
				"special": "Double The Fun"
			}
		},
		"p2": {
			1:{
				"price": 450,
				"rangeup": 40,
				"aoeup": 10,
				"dmgup": 10
			},
			2:{
				"price":950,
				"rangeup": 60,
				"aoeup": 20,
				"dmgup": 15
			},
			3:{
				"price": 2700,
				"rangeup": 100,
				"aoeup": 50,
				"dmgup": 80,
				"special": "Better Rockets"
			},
			4:{
				"price": 7200,
				"rangeup": 150,
				"aoeup": 70,
				"dmgup": 250,
				"angup": 40,
				"bulletspeedup": 200,
				"special": "Long Range Rocket Deliver Service"
			}
		}
	}
	
}
