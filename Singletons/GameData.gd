extends Node

var towerData = {
	"turret":{
		"dmg": 30,
		"range": 110,
		"as": 1.5,
		"angle": 240,
		"placement area": 43,
		"projectile": "bullet",
		},
	"rocket":{
		"dmg": 80,
		"range": 200,
		"as": 5,
		"angle": 300,
		"placement area": 35,
		"projectile": "missle",
		}
}
var enemyData = {
	"bluetank":{
		"speed": 50,
		"hp": 115,
		"base_dmg": 1,
		"KillGold": 5
	},
	"greentank":{
		"speed": 60,
		"hp": 155,
		"base_dmg": 5,
		"KillGold": 10
	},
	"whitetank":{
		"speed": 70,
		"hp": 310,
		"base_dmg": 10,
		"KillGold": 20
	},
	"redtank":{
		"speed": 65,
		"hp": 380,
		"base_dmg": 15,
		"KillGold": 30
	},
	"redminiboss":{
		"speed": 25,
		"hp": 1400,
		"base_dmg": 95,
		"KillGold": 1400
	},
	"redboss":{
		"speed": 12,
		"hp": 27000,
		"base_dmg": 100,
		"KillGold": 999999
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
var shopData = {
	"turret": {
		"price": 110
	},
	"rocket": {
		"price": 225
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"price": 150,
				"asup": -0.3,
				"bulletspeedup": 100
			},
			2:{
				"price": 320,
				"asup": -0.2,
				"bulletspeedup": 100,
				"dmgup": 10
			},
			3:{
				"price": 2000,
				"dmgup": 25,
				"angup": -15,
				"asup": -0.2,
				"special": "Super Fast Attack Mode"
			},
			4:{
				"price": 3800,
				"dmgup": 40,
				"rangup": 20,
				"bulletspeedup": 50,
				"asup": -0.2,
				"special": "Anti-Tank Machine Gun"
			}
		},
		"p2": {
			1: {
				"price": 230,
				"rangeup": 40,
				"dmgup": 10
			},
			2:{
				"price": 310,
				"rangeup": 60,
				"dmgup": 10
			},
			3:{
				"price": 1900,
				"rangeup": 150,
				"dmgup": 80,
				"bulletspeedup": 150,
				"asup": 0.3,
				"special": "Long Range Markstower"
			},
			4:{
				"price": 4100,
				"rangeup": 250,
				"asup": 1.2,
				"dmgup": 260,
				"special": "Sniper Cosplay"
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
			"price": 240,
			"asup": -0.5,
			"dmgup": 10
			},
			2:{
				"price": 420,
				"dmgup": 20,
				"asup": -0.5
			},
			3:{
				"price": 2200,
				"asup": -1,
				"dmgup": 30,
				"special": "Double The Fun"
			},
			4:{
				"price": 3800,
				"asup": -1,
				"dmgup": 60,
				"bulletspeedup": 150,
				"special": "Rapid Fire"
			}
		},
		"p2": {
			1:{
				"price": 300,
				"rangeup": 20,
				"aoeup": 15,
				"dmgup": 15
			},
			2:{
				"price":500,
				"rangeup": 40,
				"aoeup": 25,
				"dmgup": 25
			},
			3:{
				"price": 2700,
				"rangeup": 150,
				"aoeup": 50,
				"dmgup": 80,
				"special": "Better Rockets"
			},
			4:{
				"price": 4800,
				"rangeup": 200,
				"aoeup": 80,
				"dmgup": 160,
				"angup": 60,
				"bulletspeedup": 300,
				"special": "Long Range Rocket Deliver Service"
			}
		}
	}
	
}
