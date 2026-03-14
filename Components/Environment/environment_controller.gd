extends Node

var current_id : int = -1
@export var event_envs_array : Array[EventEnv]

@onready var environment : Environment = load("res://Components/Environment/world_environment.tres")
@onready var room_container : Node3D = $RoomContainer


func _ready() -> void:
	environment.background_color = Color.BLACK
	environment.fog_light_color = Color.BLACK
	GlobalSignals.event_clicked.connect(update_environment)

func update_environment(event : Event):
	if current_id == event.type : return
	current_id = event.type
	transition_environment(current_id)

func transition_environment(new_type : int):
	var event_env : EventEnv = event_envs_array[new_type]
	var tweener : Tween = create_tween()
	tweener.set_parallel()
	tweener.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tweener.tween_property(environment, "fog_depth_end", 10, 1)
	
	tweener.chain().tween_property(environment, "background_color", event_env.event_colour, 1)
	tweener.tween_property(environment, "fog_light_color", event_env.event_colour, 1)
	tweener.tween_property(environment, "fog_depth_end", 100, 1)
	tweener.tween_callback(func():
		for child in room_container.get_children():
			child.queue_free()
		room_container.add_child(event_env.room.instantiate())
	)
