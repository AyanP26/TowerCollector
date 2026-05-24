extends Node
@export var enemy: PackedScene

var score = 0
var level4enemyamount = 20
var blueprint = preload("res://blueprint.tscn")
var purpleprint = preload("res://purpleprint.tscn")
var orangeprint = preload("res://orangeprint.tscn")
var greenprint = preload("res://greenprint.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(level4enemyamount):
		var random_position = Vector2(
			randf_range(100, 1100),
			randf_range(100, 600)
		)
		var bpinst = blueprint.instantiate()
		var ppinst = purpleprint.instantiate()
		var opinst = orangeprint.instantiate()
		var gpinst = greenprint.instantiate()
		bpinst.position = random_position
		ppinst.position = random_position
		opinst.position = random_position
		gpinst.position = random_position
		add_child(bpinst)
		add_child(ppinst)
		add_child(opinst)
		add_child(gpinst)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var blueprint = blueprint.instantiate()
	add_child(blueprint)
	
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
