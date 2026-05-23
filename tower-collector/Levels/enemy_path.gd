extends PathFollow2D
@export var path: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path.progress += 0.02 * delta
	global_position = path.follow.global_position
