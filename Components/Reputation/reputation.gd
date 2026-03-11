extends Control

@export var dot : PackedScene

func _ready() -> void:
	for i in range(5):
		var dot_instance : Control = dot.instantiate()
		dot_instance.set_colour(Dot.GREY_COLOUR)
		add_child(dot_instance)
