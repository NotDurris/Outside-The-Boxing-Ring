class_name PauseLogic
extends Node

@export_group("Dependencies")
@export var zoom_slider : Slider
@export var screen_toggle : CheckButton
@export var sway_toggle : CheckButton

func _ready() -> void:
	zoom_slider.value_changed.connect(func(value) : GlobalSignals.zoom_changed.emit(value))
	screen_toggle.toggled.connect(func(value) : GlobalSignals.screen_effect_changed.emit(value))
	sway_toggle.toggled.connect(func(value) : GlobalSignals.sway_effect_changed.emit(value))
