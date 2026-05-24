extends Node

var pause_label: Label

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_key_pressed(KEY_ESCAPE) or Input.is_key_pressed(KEY_P):
		if pause_label:
			# Debounce somewhat or just use just_pressed equivalents where possible
			# is_key_pressed fires continuously, so we need a manual toggle debounce if not using actions
			pass

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE or event.keycode == KEY_P:
			var tree = get_tree()
			tree.paused = not tree.paused
			if pause_label:
				pause_label.visible = tree.paused
