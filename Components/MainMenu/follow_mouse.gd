extends Control

@export var speed : float = 10

@onready var target_material : ShaderMaterial = material

func _physics_process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position() / get_viewport_rect().size
	mouse_position.x = clamp(mouse_position.x, 0, 1)
	mouse_position.y = clamp(mouse_position.y, 0, 1)
	var new_position = lerp(target_material.get_shader_parameter("target_point"), mouse_position, speed * delta)
	target_material.set_shader_parameter("target_point", new_position)
