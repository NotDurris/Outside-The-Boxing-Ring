extends Node

var stats : Stats :
	set(value):
		if stats != value:
			stats_updated.emit(value)
		stats = value

signal stats_updated(new_stats : Stats)

var skills : Array[Skill]

var traits : Array[Trait]

func _ready() -> void:
	stats = Stats.new()
