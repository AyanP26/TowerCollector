extends RigidBody2D

@export var follow_path: PathFollow2D
var speed = 20.0


func _ready():
	add_to_group("enemies")
	var enemy_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = enemy_types.pick_random()
	$AnimatedSprite2D.play()


func _physics_process(delta):
	if not follow_path:
		return
	
	follow_path.progress += speed * delta
	global_position = follow_path.global_position
	
	if follow_path.progress_ratio >= 1.0:
		if get_tree().current_scene.has_method("game_over"):
			get_tree().current_scene.game_over()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _exit_tree():
	if follow_path and is_instance_valid(follow_path):
		follow_path.queue_free()
