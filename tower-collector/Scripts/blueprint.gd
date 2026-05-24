extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area.has_method("add_to_hotbar"):
		if area.add_to_hotbar("blueprint"):
			print("blueprint collected")
			if get_tree().current_scene.has_method("respawn_print"):
				get_tree().current_scene.respawn_print("blueprint")
			self.queue_free()

func _on_body_entered(body):
	if body.has_method("add_to_hotbar"):
		if body.add_to_hotbar("blueprint"):
			print("blueprint collected")
			if get_tree().current_scene.has_method("respawn_print"):
				get_tree().current_scene.respawn_print("blueprint")
			self.queue_free()
