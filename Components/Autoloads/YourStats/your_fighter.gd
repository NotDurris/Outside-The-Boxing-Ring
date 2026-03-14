extends Node

var stats : Stats :
	set(value):
		if stats != value:
			stats_updated.emit(value)
		stats = value

signal stats_updated(new_stats : Stats)

func _ready() -> void:
	stats = Stats.new()
	stats.skills = [load("uid://7e5d0nk40pcj"), load("uid://db4rfl2mr6l4j"), load("uid://dfn8jtwygi1y2")]
