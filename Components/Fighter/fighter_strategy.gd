extends Node

@export var strategy_ui : StrategyUI

func _ready() -> void:
	FighterStats.strategy_updated.connect(strategy_ui.update_strategy_container_from_type)
	strategy_ui.update_strategy_container_from_type(FighterStats.strategy)
