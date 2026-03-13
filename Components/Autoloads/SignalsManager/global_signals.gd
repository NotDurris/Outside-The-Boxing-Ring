# Script autoloaded, singleton for global signals allowing for cleaner communication between scripts
extends Node

# Gameplay
@warning_ignore("unused_signal")
signal event_clicked(event : Event)
@warning_ignore("unused_signal")
signal start_fight(opponent : OpponentStats)

# SubMenu
@warning_ignore("unused_signal")
signal open_pop_up_menu(sub_menu : PackedScene)
@warning_ignore("unused_signal")
signal close_pop_up_menu()
