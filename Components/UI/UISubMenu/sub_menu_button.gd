extends Button

@export var contents : PackedScene

func _ready() -> void:
	pressed.connect(func() : GlobalSignals.open_pop_up_menu.emit(contents))
