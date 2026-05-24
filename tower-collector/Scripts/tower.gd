extends RigidBody2D

signal hit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("build"):
		$AnimatedSprite2D.play("build")


func _on_body_entered(body: Node) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deffered("disabled", true)
	
