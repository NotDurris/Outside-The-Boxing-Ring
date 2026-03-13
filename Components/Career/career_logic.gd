extends Control

@export_group("Event Composition")
@export var fight_count : int = 3
@export var rest_count : int = 1
@export var train_count : int = 2
@export var rando_count : int = 1
@export_group("Dependencies")
@export var ranks : Array[Rank]

var fight_buttons : Array[Event]
var rest_buttons : Array[Event]
var train_buttons : Array[Event]

const EVENT = preload("uid://bta5mcq7j6vk")

func _ready() -> void:
	initialise_events()

func initialise_events():
	for rank in ranks:
		for i in range(fight_count):
			create_event_btn(Event.EventType.Fight, rank)
		for i in range(rest_count):
			create_event_btn(Event.EventType.Rest, rank)
		for i in range(train_count):
			create_event_btn(Event.EventType.Train, rank)
		for i in range(rando_count):
			create_event_btn(randi_range(0,2) as Event.EventType, rank)

func create_event_btn(type : Event.EventType, rank : Rank):
	var event_btn : Event = EVENT.instantiate()
	event_btn.type = type
	
	match type:
		Event.EventType.Fight:
			fight_buttons.append(event_btn)
		Event.EventType.Rest:
			rest_buttons.append(event_btn)
		Event.EventType.Train:
			train_buttons.append(event_btn)
	
	rank.event_container.add_child(event_btn)
