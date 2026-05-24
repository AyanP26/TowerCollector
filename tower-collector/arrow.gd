extends Area2D

var target = null
var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null and is_instance_valid(target):
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
		look_at(target.global_position)
	else:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
		queue_free()
