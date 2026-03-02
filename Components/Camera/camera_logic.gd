extends Camera3D

@export var max_offset : Vector2
@export var rotation_speed : float

var offset : Vector2 = Vector2.ZERO

@onready var initial : Vector3 = rotation
@onready var target_rotation : Vector3 = initial
@onready var previous_mouse_position : Vector2 = get_viewport().get_mouse_position()

func _process(_delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position() / get_viewport().get_visible_rect().size
	
	mouse_position = Vector2.ONE - mouse_position
	
	offset.x = lerp(-max_offset.x, max_offset.x, mouse_position.x)
	offset.y = lerp(-max_offset.y, max_offset.y, mouse_position.y)
	
	rotation = initial + Vector3(offset.y,offset.x,0)
