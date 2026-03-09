extends Node

var stats : Stats :
	set(value):
		if stats != value:
			stats_updated.emit(value)
		stats = value

signal stats_updated(new_stats : Stats)

func _ready() -> void:
	stats = Stats.new()
