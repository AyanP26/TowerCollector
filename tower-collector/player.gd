extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vel = Vector2.ZERO
	if Input.is_action_pressed("up"):
		vel.y += 1
	if Input.is_action_pressed("down"):
		vel.y -= 1
	if Input.is_action_pressed("right"):
		vel.x += 1
	if Input.is_action_pressed("left"):
		vel.x -= 1
		
	if vel.length() > 0:
		vel = vel.normalized() * 5
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
		
