class_name Event
extends Button

const FIGHT_ICON := preload("uid://mm8tj2eop46")
const TRAIN_ICON := preload("uid://kmcec7e4fpkp")
const REST_ICON = preload("uid://csfoeefvxqsd2")

const FIGHT_COLOUR := Color(0.979, 0.408, 0.317, 1.0)
const TRAIN_COLOUR := Color(0.195, 0.783, 0.93, 1.0)
const REST_COLOUR := Color(0.458, 0.809, 0.402, 1.0)

enum EventType {Fight, Rest, Train, Boss, Random}
@export var type : EventType

func _ready():
	if type == EventType.Random:
		type = randi_range(0,2) as EventType
	update_visual()
	
	pressed.connect(func() : GlobalSignals.event_clicked.emit(self))

func update_visual():
	match type:
		EventType.Fight:
			icon = FIGHT_ICON
			self_modulate = FIGHT_COLOUR
		EventType.Rest:
			icon = REST_ICON
			self_modulate = TRAIN_COLOUR
		EventType.Train:
			icon = TRAIN_ICON
			self_modulate = REST_COLOUR
		EventType.Boss:
			icon = FIGHT_ICON
			self_modulate = Color(0.333, 0.333, 0.333, 1.0)
