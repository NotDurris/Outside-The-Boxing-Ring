extends Control

@export_group("Rank Settings")
@export var rank : int
@export var colour : Color
@export var locked : bool = true

const EVENT = preload("uid://bta5mcq7j6vk")
@onready var event_container : Container = $RankContents/Level/Container
@export_group("Event Composition")
@export var fight_count : int = 3
@export var rest_count : int = 1
@export var train_count : int = 2

@export_group("Dependencies")
@export var rank_label: Label
@export var background: ColorRect
@export var lock_screen: Control

func _ready() -> void:
	rank_label.text = str(rank)
	background.color = colour
	lock_screen.visible = locked
	
	create_events()

func create_events():
	for i in range(fight_count):
		create_event_btn(EventBtn.EventType.Fight)
	for i in range(rest_count):
		create_event_btn(EventBtn.EventType.Rest)
	for i in range(train_count):
		create_event_btn(EventBtn.EventType.Train)

func create_event_btn(type : EventBtn.EventType):
	var event_btn : EventBtn = EVENT.instantiate()
	event_btn.type = type
	event_container.add_child(event_btn)
