extends Control

const GREY_COLOUR : Color = Color("353535ff")
const RED_COLOUR : Color = Color("e53c2aff")

@export var dot : PackedScene

func _ready() -> void:
	for i in range(5):
		var dot_instance : Control = dot.instantiate()
		dot_instance.self_modulate = GREY_COLOUR
		add_child(dot_instance)
