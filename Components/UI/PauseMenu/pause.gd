class_name PauseLogic
extends SubMenu

@export_group("Dependencies")
@export var zoom_slider : Slider
@export var screen_toggle : CheckButton
@export var sway_toggle : CheckButton

func _ready() -> void:
	zoom_slider.value = Settings.zoom
	screen_toggle.button_pressed = Settings.screen_effect
	sway_toggle.button_pressed = Settings.sway_effect
	
	zoom_slider.value_changed.connect(func(value) : Settings.zoom = value)
	screen_toggle.toggled.connect(func(value) : Settings.screen_effect = value)
	sway_toggle.toggled.connect(func(value) : Settings.sway_effect = value)
