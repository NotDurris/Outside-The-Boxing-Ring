# Script autoloaded, singleton for global signals allowing for cleaner communication between scripts
extends Node

# Pause Menu Settings
@warning_ignore("unused_signal")
signal zoom_changed(new_value : float)
@warning_ignore("unused_signal")
signal screen_effect_changed(new_value : bool)
@warning_ignore("unused_signal")
signal sway_effect_changed(new_value : bool)
