extends Node

var selected_event : Event

const FIGHT_SUB_MENU = preload("uid://b368iaeoy10mo")
const REST_SUB_MENU = preload("uid://cw33gbms8nr1b")
const TRAIN_SUB_MENU = preload("uid://d2xfieuj21bw5")

func _ready() -> void:
	GlobalSignals.event_clicked.connect(event_selected)

func event_selected(target_event : Event):
	selected_event = target_event
	
	match selected_event.type:
		Event.EventType.Fight:
			GlobalSignals.open_pop_up_menu.emit(FIGHT_SUB_MENU)
		Event.EventType.Rest:
			GlobalSignals.open_pop_up_menu.emit(REST_SUB_MENU)
		Event.EventType.Train:
			GlobalSignals.open_pop_up_menu.emit(TRAIN_SUB_MENU)
