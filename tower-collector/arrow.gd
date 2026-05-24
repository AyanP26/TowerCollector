extends Area2D

var target = null
var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
if(target != null):
var direction = (target.global_position - global_position).normalized()
global_position += direction * speed * delta

look_at(target.global_position)
