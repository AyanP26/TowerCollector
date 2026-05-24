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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(level1enemyamount):
		var bpinst = blueprint.instantiate()
		var ppinst = purpleprint.instantiate()
		var opinst = orangeprint.instantiate()
		var gpinst = greenprint.instantiate()
		
		bpinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		ppinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		opinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		gpinst.position = Vector2(randf_range(50, screen_size[0] - 50), randf_range(50, screen_size[1] - 50))
		
		add_child(bpinst)
		add_child(ppinst)
		add_child(opinst)
		add_child(gpinst)
	
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
	
	var tower = tower.instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
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
		
	
func _on_enemy_timer_timeout() -> void:
	var enemy = enemy.instantiate()
	
	enemy.position = $EnemyPath/EnemyPathFollow.position
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	
	add_child(enemy)	


func _on_score_timer_timeout() -> void:
	score += 1


func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()
	$ScoreTimer.start()
