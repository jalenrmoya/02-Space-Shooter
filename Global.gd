extends Node

var VP = Vector2.ZERO

var score = 0
var time = 0
var lives = 0
var ammo = 0

func _ready():
	reset()
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	#VP = get_viewport().size
	VP = Vector2(1280,1175)
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")


func _resize():
	#VP = get_viewport().size
	#var HUD = get_node_or_null("/root/game/UI/HUD")
	#if HUD != null:
	#	HUD.update_lives()
	pass
func reset():
	get_tree().paused = false
	score = 0
	time = 30
	lives = 5
	ammo = 20

func update_lives(l):
	lives -= 1
	if lives < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var HUD = get_node_or_null("/root/Game/UI/HUD")
		if HUD != null:
			HUD.update_lives()

func update_ammo(a):
	ammo += a
	print(ammo)
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_ammo()
		
func update_score(s):
	score+= s
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_score()

func _physics_process(_delta):
	var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Asteroid_Container != null and Enemy_Container != null:
		if Asteroid_Container.get_child_count() == 0 and Enemy_Container.get_child_count() == 0:
			var _scene = get_tree().change_scene("res://UI/End_Game.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var Menu = get_node_or_null("/root/Game/UI/Menu")
		if Menu == null:
			get_tree().quit()
		else:
			if Menu.visible:
				get_tree().paused = false
				Menu.hide()
			else:
				get_tree().paused = true
				Menu.show()
