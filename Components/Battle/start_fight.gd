extends Button

func start_battle():
	disabled = true
	GlobalSignals.close_pop_up_menu.emit()
	GlobalSignals.start_fight.emit(Stats.new())
