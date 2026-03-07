extends MeshInstance3D

var shader_mat : ShaderMaterial

func _ready() -> void:
	shader_mat = get_active_material(2)
	GlobalSignals.screen_effect_changed.connect(toggle_screen_effect)

func _exit_tree() -> void:
	GlobalSignals.screen_effect_changed.disconnect(toggle_screen_effect)

func toggle_screen_effect(value : bool):
	shader_mat.set_shader_parameter("apply_pixels", value)
