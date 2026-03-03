extends Node

@export var screens : Array[Control]

@export var active_screen : int :
	set(value):
		active_screen = value
		for i in range(screens.size()):
			if active_screen == i:
				screens[i].show()
			else:
				screens[i].hide()

func _ready() -> void:
	active_screen = active_screen

func set_active_screen(target_screen : int):
	if active_screen == target_screen : return
	active_screen = target_screen
