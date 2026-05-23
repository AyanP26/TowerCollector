extends Node
@export var enemy: PackedScene
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
