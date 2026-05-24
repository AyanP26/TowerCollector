extends RigidBody2D

signal hit

var arrow_scene = preload("res://Nodes/arrow.tscn")
@export var range = 200.0
@export var shoot_cooldown = 1.5
var shoot_timer = 0.0

var tower_color = ""
var is_built = false
var final_sprite = null

func setup(color):
	tower_color = color
	if color == "blueprint":
		max_shots = 3
	elif color == "greenprint":
		max_shots = 4
	elif color == "orangeprint":
		max_shots = 5
	elif color == "purpleprint":
		max_shots = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	gravity_scale = 0.0
	freeze = true
	$AnimatedSprite2D.play("build")
	$AnimatedSprite2D.pause()
	$AnimatedSprite2D.frame = 0

func set_build_frame(frame):
	if is_built == false:
		$AnimatedSprite2D.frame = frame

func finalize_build():
	if is_built == false:
		is_built = true
		$AnimatedSprite2D.hide()
		final_sprite = Sprite2D.new()
		
		if tower_color == "blueprint":
			final_sprite.texture = preload("res://Sprites/Tower/cyantower.png")
		elif tower_color == "greenprint":
			final_sprite.texture = preload("res://Sprites/Tower/greentower.png")
		elif tower_color == "orangeprint":
			final_sprite.texture = preload("res://Sprites/Tower/orangetower.png")
		elif tower_color == "purpleprint":
			final_sprite.texture = preload("res://Sprites/Tower/purpletower.png")
			
		final_sprite.position = $AnimatedSprite2D.position
		add_child(final_sprite)

var lifespan = 30.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_built:
		lifespan -= delta
		if lifespan <= 0:
			queue_free()
			
		shoot_timer -= delta
		if shoot_timer <= 0:
			shoot_timer = shoot_cooldown
			shoot_at_enemy()

var shots_fired = 0
var max_shots = 4

func shoot_at_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest_enemy = null
	var closest_dist = range

	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue
		var dist = global_position.distance_to(enemy.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest_enemy = enemy
			
	if closest_enemy != null and arrow_scene != null:
		var arrow = arrow_scene.instantiate()
		arrow.speed = 600
		arrow.global_position = global_position
		arrow.target = closest_enemy
		get_tree().current_scene.add_child(arrow)
		
		shots_fired += 1
		if shots_fired >= max_shots:
			queue_free()

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
