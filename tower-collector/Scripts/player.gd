extends Area2D

@export var speed = 200
var screen_size
var hotbar = [" ", " ", " ", " "]
var active_slot = 0
var tower_scene = preload("res://Nodes/tower.tscn")
var arrow_scene = preload("res://Nodes/arrow.tscn")

var is_building = false
var build_timer = 0.0
var build_duration = 2.0
var current_tower = null

var attack_cooldown = 1.0
var attack_timer = 0.0

var hotbar_sprites = [null, null, null, null]

func add_to_hotbar(item_name):
	for i in range(4):
		if hotbar[i] == " ":
			hotbar[i] = item_name
			
			var sprite = Sprite2D.new()
			if item_name == "blueprint":
				sprite.texture = preload("res://Sprites/Prints/blueprint.png")
			elif item_name == "greenprint":
				sprite.texture = preload("res://Sprites/Prints/greenprint.png")
			elif item_name == "orangeprint":
				sprite.texture = preload("res://Sprites/Prints/orangeprint.png")
			elif item_name == "purpleprint":
				sprite.texture = preload("res://Sprites/Prints/purpleprint.png")
				
			sprite.position = Vector2(956 + (i * 61) + 30, 33)
			sprite.z_index = 100
			get_tree().current_scene.add_child(sprite)
			hotbar_sprites[i] = sprite
			
			return true
	return false

func attack():
	if attack_timer > 0:
		return
	attack_timer = attack_cooldown
	$AnimatedSprite2D.play("playerAttack")
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest_enemy = null
	var closest_dist = 400.0

	for enemy in enemies:
		if is_instance_valid(enemy) == false:
			continue
		var dist = global_position.distance_to(enemy.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest_enemy = enemy
			
	if closest_enemy != null and arrow_scene != null:
		var arrow = arrow_scene.instantiate()
		arrow.speed = 300
		arrow.global_position = global_position
		arrow.target = closest_enemy
		get_tree().current_scene.add_child(arrow)

func finish_building():
	if current_tower:
		current_tower.finalize_build()
		current_tower = null
	
	hotbar[active_slot] = " "
	if not hotbar_sprites[active_slot] == null:
		hotbar_sprites[active_slot].queue_free()
		hotbar_sprites[active_slot] = null


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	if attack_timer > 0:
		attack_timer -= delta

	var vel = Vector2.ZERO
	if Input.is_action_pressed("up"):
		vel.y -= 1
	if Input.is_action_pressed("down"):
		vel.y += 1
	if Input.is_action_pressed("right"):
		vel.x += 1
	if Input.is_action_pressed("left"):
		vel.x -= 1
		
	if Input.is_action_just_pressed("hotbar1") or Input.is_key_pressed(KEY_1):
		active_slot = 0
	elif Input.is_action_just_pressed("hotbar2") or Input.is_key_pressed(KEY_2):
		active_slot = 1
	elif Input.is_action_just_pressed("hotbar3") or Input.is_key_pressed(KEY_3):
		active_slot = 2
	elif Input.is_action_just_pressed("hotbar4") or Input.is_key_pressed(KEY_4):
		active_slot = 3

	if vel.length() > 0 and is_building:
		is_building = false
		build_timer = 0.0
		if current_tower != null:
			current_tower.queue_free()
			current_tower = null

	if Input.is_action_just_pressed("build") and vel.length() == 0 and is_building == false:
		if hotbar[active_slot] != " ":
			is_building = true
			build_timer = build_duration
			$AnimatedSprite2D.play("playerBuild")
			
			current_tower = tower_scene.instantiate()
			current_tower.setup(hotbar[active_slot])
			current_tower.global_position = global_position + Vector2(50, 0)
			get_tree().current_scene.add_child(current_tower)
			
	if Input.is_action_just_pressed("attack") and vel.length() == 0 and not is_building:
		attack()

	if is_building:
		vel = Vector2.ZERO
		build_timer -= delta
		
		if current_tower != null:
			var progress = 1.0 - (build_timer / build_duration)
			var frame = int(progress * 4)
			if frame > 3: frame = 3
			current_tower.set_build_frame(frame)
			
		if build_timer <= 0:
			is_building = false
			finish_building()

	if is_building:
		pass
	elif vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite2D.play("playerWalk")
	elif attack_timer > 0:
		pass
	else:
		if not $AnimatedSprite2D.animation == "playerAttack" and not $AnimatedSprite2D.animation == "playerBuild":
			$AnimatedSprite2D.stop()
		
	position += vel * delta
	position = position.clamp(Vector2.ZERO, screen_size)
