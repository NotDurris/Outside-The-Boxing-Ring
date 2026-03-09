# Script autoloaded, singleton for global signals allowing for cleaner communication between scripts
extends Node

# Gameplay
@warning_ignore("unused_signal")
signal event_clicked(event : Event)

# SubMenu
@warning_ignore("unused_signal")
signal open_pop_up_menu(title : String, sub_menu : PackedScene)
