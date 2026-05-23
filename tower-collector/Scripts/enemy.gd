extends RigidBody2D
@export var follow_path: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = enemy_types.pick_random()
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if follow_path == null:
		print("fn")
		return
	
	follow_path.progress += 20 * delta
	global_position = follow_path.global_position
