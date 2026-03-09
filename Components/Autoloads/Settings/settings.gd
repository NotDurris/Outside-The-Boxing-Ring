extends Node

# Pause Menu Settings
var zoom : float = 0.0 :
	set(value):
		zoom = value
		zoom_changed.emit(value)
@warning_ignore("unused_signal")
signal zoom_changed(new_value : float)

var screen_effect : bool = true :
	set(value):
		screen_effect = value
		screen_effect_changed.emit(value)
@warning_ignore("unused_signal")
signal screen_effect_changed(new_value : bool)

var sway_effect : bool = true :
	set(value):
		sway_effect = value
		sway_effect_changed.emit(value)
@warning_ignore("unused_signal")
signal sway_effect_changed(new_value : bool)
