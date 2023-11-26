extends Node

var towerData = {
	"turret":{
		"dmg": 35,
		"range": 120,
		"as": 1.5,
		"angle": 240,
		"placement area": 43,
		"projectile": "bullet",
		},
	"rocket":{
		"dmg": 70,
		"range": 200,
		"as": 5.5,
		"angle": 360,
		"placement area": 35,
		"projectile": "missle",
		}
}
var enemyData = {
	"bluetank":{
		"speed": 50,
		"hp": 120,
		"base_dmg": 1,
		"KillGold": 5
	},
	"redtank":{
		"speed": 60,
		"hp": 220,
		"base_dmg": 10,
		"KillGold": 10
	},
	"redboss":{
		"speed": 10,
		"hp": 50000,
		"base_dmg": 100,
		"killGold": 999999
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
	1: [[4, "blue_tank", 1]],
	2: [[6, "blue_tank", 1]],
	3: [[8, "blue_tank", 0.7]],
	4: [[8, "blue_tank", 0.5]],
	5: [[12, "blue_tank", 0.5]],
	6: [[30, "blue_tank", 1.5]],
	7: [[20, "blue_tank", 1]],
	8: [[40, "blue_tank", 1]],
	9: [[5, "blue_tank", 1], [1, "blue_tank", 4], [55, "blue_tank", 0.8]],
	10: [[30, "blue_tank", 0.5], [1, "blue_tank", 3], [5, "red_tank", 1]],
	11: [[15, "blue_tank", 0.5], [10, "red_tank", 1]],
	12: [[5, "blue_tank", 0.3], [15, "red_tank", 0.7]],
	13: [[1, "blue_tank", 5], [20, "red_tank", 0.5]],
	14: [[60, "blue_tank", 0.2], [3, "red_tank", 0.5]],
	15: [[21, "red_tank", 1.5], [10, "red_tank", 1], [6, "red_tank", 0.7], [3, "red_tank", 0.5]],
	16: [[20, "red_tank", 0.7]],
	17: [[15, "red_tank", 0.5]],
	18: [[25, "red_tank", 0.7]],
	19: [[30, "red_tank", 0.7], [1, "red_tank", 4], [1, "red_tank", 4], [20, "red_tank", 0.5]],
	20: [[1, "red_boss", 1]]
}
var shopData = {
	"turret": {
		"price": 150
	},
	"rocket": {
		"price": 300
	}
}
var upgradeData = {
	"turret": {
		"p1": {
			1: {
				"price": 130,
				"asup": -0.3,
				"bulletspeedup": 100
			},
			2:{
				"price": 320,
				"asup": -0.5,
				"bulletspeedup": 100,
				"dmgup": 10
			},
			3:{
				"price": 1400,
				"dmgup": 25,
				"angup": -30,
				"special": "Super Fast Attack Mode"
			},
			4:{
				"price": 2100,
				"dmgup": 15,
				"rangup": 30,
				"bulletspeedup": 50,
				"special": "Anti-Tank Machine Gun"
			}
		},
		"p2": {
			1: {
				"price": 160,
				"rangeup": 30,
				"dmgup": 5
			},
			2:{
				"price": 400,
				"rangeup": 50,
				"dmgup": 10
			},
			3:{
				"price": 1300,
				"rangeup": 150,
				"dmgup": 30,
				"bulletspeedup": 150,
				"special": "Long Range Markstower"
			},
			4:{
				"price": 2700,
				"rangeup": 250,
				"asup": 2,
				"dmgup": 130,
				"special": "Sniper Cosplay"
			}
		}
		
	},
	"rocket": {
		"p1" :{
			1: {
			"price": 150,
			"asup": -0.5
			},
			2:{
				"price": 350,
				"dmgup": 20,
				"asup": -0.5
			},
			3:{
				"price": 1300,
				"asup": -0.5,
				"special": "Double The Fun"
			},
			4:{
				"price": 2300,
				"asup": -2.5,
				"dmgup": 30,
				"special": "Rapid Fire"
			}
		},
		"p2": {
			1:{
				"price": 200,
				"rangeup": 10,
				"aoeup": 10,
				"dmgup": 10
			},
			2:{
				"price":440,
				"rangeup": 40,
				"aoeup": 20,
				"dmgup": 20
			},
			3:{
				"price": 1200,
				"rangeup": 100,
				"aoeup": 30,
				"dmgup": 40,
				"special": "Better Rockets"
			},
			4:{
				"price": 2600,
				"rangeup": 150,
				"aoeup": 30,
				"dmgup": 60,
				"special": "Long Range Rocket Deliver Service"
			}
		}
	}
	
}
