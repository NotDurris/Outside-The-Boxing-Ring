extends Control

@export var strength : float = 0.02

var initial_position : Vector2 

func _ready() -> void:
	initial_position = position

func _physics_process(_delta: float) -> void:
	var half_rect := get_viewport_rect().size * 0.5
	var mouse_position = get_viewport().get_mouse_position() - half_rect
	mouse_position.x = clamp(mouse_position.x, -half_rect.x, half_rect.x)
	mouse_position.y = clamp(mouse_position.y, -half_rect.y, half_rect.y)
	position = initial_position + mouse_position  * strength
