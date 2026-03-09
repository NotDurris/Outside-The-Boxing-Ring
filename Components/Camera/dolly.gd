extends Node3D

const ZOOMED_OUT_POSITION = Vector3(0.0, 1.5, 2)
const ZOOMED_IN_POSITION = Vector3(0.0, 1.1, 0.7)

const ZOOMED_OUT_ROTATION = Vector3(-45, 0.0, 0.0)
const ZOOMED_IN_ROTATION = Vector3(-60, 0.0, 0.0)

func _ready() -> void:
	Settings.zoom_changed.connect(update_zoom)

func _exit_tree() -> void:
	Settings.zoom_changed.disconnect(update_zoom)

func update_zoom(value) : zoom = value

var zoom : float = 0.0 :
	set(value):
		zoom = value
		var target_position = lerp(ZOOMED_OUT_POSITION, ZOOMED_IN_POSITION, value)
		var target_rotation = lerp(ZOOMED_OUT_ROTATION, ZOOMED_IN_ROTATION, value)
		var tweener = create_tween()
		tweener.set_parallel()
		tweener.tween_property(self, "position", target_position, 0.1)
		tweener.tween_property(self, "rotation_degrees", target_rotation, 0.1)
