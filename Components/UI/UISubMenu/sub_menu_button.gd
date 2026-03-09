extends Button

@export var title : String
@export var contents : PackedScene

func _ready() -> void:
	pressed.connect(func() : GlobalSignals.open_pop_up_menu.emit(title, contents))
