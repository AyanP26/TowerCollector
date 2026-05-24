extends Node

@export var enemy: PackedScene
@export var tower: PackedScene

var score = 0
var level1enemyamount = 10

var blueprint = preload("res://Nodes/blueprint.tscn")
var purpleprint = preload("res://Nodes/purpleprint.tscn")
var orangeprint = preload("res://Nodes/orangeprint.tscn")
var greenprint = preload("res://Nodes/greenprint.tscn")

var hotbar = preload("res://Nodes/Hotbar/hotbar.tscn")
var hotbar1 = preload("res://Nodes/Hotbar/hotbar_1.tscn")
var hotbar2 = preload("res://Nodes/Hotbar/hotbar_2.tscn")
var hotbar3 = preload("res://Nodes/Hotbar/hotbar_3.tscn")
var hotbar4 = preload("res://Nodes/Hotbar/hotbar_4.tscn")

var screen_size = [1200, 720]

@onready var hbinst = hotbar.instantiate()
@onready var hb1inst = hotbar1.instantiate()
@onready var hb2inst = hotbar2.instantiate()
@onready var hb3inst = hotbar3.instantiate()
@onready var hb4inst = hotbar4.instantiate()

var current_wave = 1
var enemies_to_spawn = 25
var enemies_spawned = 0
var wave_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var path_line = Line2D.new()
	path_line.points = $EnemyPath.curve.get_baked_points()
	path_line.width = 10.0
	path_line.default_color = Color(0.4, 0.3, 0.2, 0.5)
	$EnemyPath.add_child(path_line)
	
	for i in range(2):
		var bpinst = blueprint.instantiate()
		bpinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		add_child(bpinst)
	for i in range(1):
		var gpinst = greenprint.instantiate()
		gpinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		add_child(gpinst)
	for i in range(1):
		var opinst = orangeprint.instantiate()
		opinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		add_child(opinst)
	for i in range(0):
		var ppinst = purpleprint.instantiate()
		ppinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		add_child(ppinst)
		
	hbinst.position = Vector2(956, 0)
	hb1inst.position = Vector2(956, 0)
	hb2inst.position = Vector2(956, 0)
	hb3inst.position = Vector2(956, 0)
	hb4inst.position = Vector2(956, 0)
	
	hbinst.size = Vector2(244, 66)
	hb1inst.size = Vector2(244, 66)
	hb2inst.size = Vector2(244, 66)
	hb3inst.size = Vector2(244, 66)
	hb4inst.size = Vector2(244, 66)
	
	add_child(hbinst)
	add_child(hb1inst)
	add_child(hb2inst)
	add_child(hb3inst)
	add_child(hb4inst)
	
	hb1inst.hide()
	hb2inst.hide()
	hb3inst.hide()
	hb4inst.hide()

	$StartTimer.start()

func respawn_print(color):
	var new_print = null
	if color == "blueprint":
		new_print = blueprint.instantiate()
	elif color == "greenprint":
		new_print = greenprint.instantiate()
	elif color == "orangeprint":
		new_print = orangeprint.instantiate()
	elif color == "purpleprint":
		new_print = purpleprint.instantiate()
		
	if new_print != null:
		new_print.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		call_deferred("add_child", new_print)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if Input.is_action_just_pressed("hotbar1"):
		hb1inst.show()
		hb2inst.hide()
		hb3inst.hide()
		hb4inst.hide()
		hbinst.hide()
	if Input.is_action_just_pressed("hotbar2"):
		hb1inst.hide()
		hb2inst.show()
		hb3inst.hide()
		hb4inst.hide()
		hbinst.hide()
	if Input.is_action_just_pressed("hotbar3"):
		hb1inst.hide()
		hb2inst.hide()
		hb3inst.show()
		hb4inst.hide()
		hbinst.hide()
	if Input.is_action_just_pressed("hotbar4"):
		hb1inst.hide()
		hb2inst.hide()
		hb3inst.hide()
		hb4inst.show()
		hbinst.hide()
		
	if wave_active and enemies_spawned >= enemies_to_spawn:
		var enemies_alive = get_tree().get_nodes_in_group("enemies").size()
		if enemies_alive == 0:
			wave_active = false
			current_wave += 1
			enemies_to_spawn += 5
			
			if enemies_to_spawn > 65:
				var canvas = CanvasLayer.new()
				var label = Label.new()
				label.text = "YOU WIN!"
				label.add_theme_font_size_override("font_size", 100)
				label.add_theme_color_override("font_color", Color(1, 1, 0))
				label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
				canvas.add_child(label)
				add_child(canvas)
				await get_tree().create_timer(3.0).timeout
				get_tree().change_scene_to_file("res://Levels/level_1.tscn")
			else:
				$StartTimer.start()
	
func _on_enemy_timer_timeout():
	if enemies_spawned < enemies_to_spawn:
		var path_follow = PathFollow2D.new()
		path_follow.loop = false
		$EnemyPath.add_child(path_follow)
		
		var enemy_inst = enemy.instantiate()
		enemy_inst.follow_path = path_follow
		enemy_inst.speed = 30.0
		add_child(enemy_inst)
		enemies_spawned += 1
		
	if enemies_spawned >= enemies_to_spawn:
		$EnemyTimer.stop()

func _on_tower_built(color):
	var twrinst = tower.instantiate()

func _on_score_timer_timeout():
	score += 1

func game_over():
	var canvas = CanvasLayer.new()
	var label = Label.new()
	label.text = "GAME OVER"
	label.add_theme_font_size_override("font_size", 100)
	label.add_theme_color_override("font_color", Color(1, 0, 0))
	label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	canvas.add_child(label)
	add_child(canvas)
	get_tree().paused = true
	await get_tree().create_timer(2.0).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_start_timer_timeout():
	wave_active = true
	enemies_spawned = 0
	$EnemyTimer.start()
	$ScoreTimer.start()
