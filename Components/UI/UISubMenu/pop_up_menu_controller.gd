extends Node

@export var menu : UIPanel

func _ready() -> void:
	GlobalSignals.open_pop_up_menu.connect(menu.open_and_change_contents)
