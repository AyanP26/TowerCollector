extends Area2D

@export var speed = 400
var screen_size

func attack() -> void:
	print("attack")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vel = Vector2.ZERO
	if Input.is_action_pressed("up"):
		vel.y -= 1
	if Input.is_action_pressed("down"):
		vel.y += 1
	if Input.is_action_pressed("right"):
		vel.x += 1
	if Input.is_action_pressed("left"):
		vel.x -= 1
	if Input.is_action_just_pressed("attack"):
		if vel.length() == 0:
			attack()
		
	if vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite2D.play("playerWalk")
	else:
		if Input.is_action_just_pressed("attack"):
			$AnimatedSprite2D.play("playerAttack")
		else:
			if not $AnimatedSprite2D.animation == "playerAttack":
				$AnimatedSprite2D.stop()
		
	position += vel * delta
	position = position.clamp(Vector2.ZERO, screen_size)	
