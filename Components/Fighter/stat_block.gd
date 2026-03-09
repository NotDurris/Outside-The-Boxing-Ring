extends Control

@export var aggro_label : Label
@export var endurance_label : Label
@export var agility_label : Label

func _ready() -> void:
	update_labels(FighterStats.stats)
	FighterStats.stats_updated.connect(func(value) : update_labels(value))

func update_labels(stats : Stats):
	aggro_label.text = str(stats.aggro_max)
	endurance_label.text = str(stats.endurance_max)
	agility_label.text = str(stats.agility_max)
