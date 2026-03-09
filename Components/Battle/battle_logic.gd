extends Control

var current_phase : Phase
enum Phase {Planning, Execution, Resolution}

var opponent_stats : OpponentStats

@export_group("Dependencies")
@export var fighter_strategy_ui : StrategyUI
@export var opponent_strategy_ui : StrategyUI

var fighter_dice : Array[dice]
var opponent_dice : Array[dice]

func _ready() -> void:
	start_battle(OpponentStats.new())

func start_battle(opponent : OpponentStats):
	opponent_stats = opponent
	
	show()
	
	initialise()

func initialise():
	generate_opponents_strategy()
	get_fighters_strategy()
	
	fighter_strategy_ui.update_strategy_from_dice(fighter_dice)
	opponent_strategy_ui.update_strategy_from_dice(opponent_dice)

func generate_opponents_strategy():
	for i in range(opponent_stats.stamina):
		var random_type : dice.DiceType = randi_range(0,2) as dice.DiceType
		var sides = 0
		match random_type:
			dice.DiceType.Aggro:
				sides = opponent_stats.aggro_max
			dice.DiceType.Endurance:
				sides = opponent_stats.endurance_max
			dice.DiceType.Agility:
				sides = opponent_stats.agility_max
		var new_die = dice.new(sides, random_type)
		new_die.roll()
		opponent_dice.append(new_die)

func get_fighters_strategy():
	for type in FighterStats.stats.strategy:
		var sides = 0
		match type:
			dice.DiceType.Aggro:
				sides = FighterStats.stats.aggro_max
			dice.DiceType.Endurance:
				sides = FighterStats.stats.endurance_max
			dice.DiceType.Agility:
				sides = FighterStats.stats.agility_max
		var new_die = dice.new(sides, type)
		new_die.roll()
		fighter_dice.append(new_die)
