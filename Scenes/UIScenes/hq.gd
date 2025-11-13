extends Panel
signal UFUpd(uf)

var uf

var backBtn
enum BackSetup {
	DEF,
	UF,
	GEN,
	TSHOP,
}
var backCur = BackSetup.DEF

var ufBtn
var genBtn
var tshopBtn

var ufLabe
var hud
var hqUi
var tShop
var ufUi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backBtn = $CanvasLayer/MarginContainer/Exit
	ufBtn = $MarginContainer/HBoxContainer/Uf
	genBtn = $MarginContainer/HBoxContainer/Generals
	tshopBtn = $MarginContainer/HBoxContainer/Towers
	
	hqUi = $MarginContainer
	hud = $CanvasLayer
	ufLabe = $CanvasLayer/MarginContainer/UF
	
	tShop = $TowerShop
	ufUi = $ufUpgrades
	
	ufUi.left.connect(on_back_pressed)
	tshopBtn.pressed.connect(on_towershop_pressed)
	genBtn.pressed.connect(on_generals_pressed)
	ufBtn.pressed.connect(on_uf_pressed)
	backBtn.pressed.connect(on_back_pressed.bind(uf))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_generals_pressed():
	pass
	#TODO

func on_uf_pressed():
	ufUi.visible = true
	backCur = BackSetup.UF
	hud.visible = false
	ufUi.uf = uf
	ufUi.updateUF()
	ufUi.get_node("CanvasLayer").visible = true
	ufUi.cameraSwitch()
	hud.visible = false
	
	

func on_towershop_pressed():
	tShop.visible = true
	backCur = BackSetup.TSHOP
	hqUi.visible = false

func on_back_pressed(newuf):
	match(backCur):
		BackSetup.DEF:
			emit_signal("UFUpd", uf)
			hud.visible = false
			visible = false
		BackSetup.UF:
			uf = newuf
			hud.visible = true
			ufUi.get_node("CanvasLayer").visible = false
			ufUi.visible = false
			newuf = uf
			updateUF()
			backCur = BackSetup.DEF
		BackSetup.TSHOP:
			newuf = uf
			tShop.visible = false
			hud.visible = true
			backCur = BackSetup.DEF
		BackSetup.GEN:
			pass

func updateUF():
	ufLabe.text = "UF: " + str(uf)
