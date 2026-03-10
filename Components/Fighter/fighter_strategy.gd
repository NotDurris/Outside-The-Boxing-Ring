extends Node

@export var strategy_ui : StrategyUI

func _ready() -> void:
	YourFighter.stats_updated.connect(func(value) : strategy_ui.update_strategy_container_from_type(value.strategy))
	strategy_ui.update_strategy_container_from_type(YourFighter.stats.strategy)
