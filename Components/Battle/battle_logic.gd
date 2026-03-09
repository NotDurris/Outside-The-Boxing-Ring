extends MarginContainer

var current_phase : Phase
enum Phase {Planning, Execution, Resolution}

var opponent_stats : OpponentStats

@export_group("Dependencies")
@export var fighter_strategy_ui : StrategyUI
@export var opponent_strategy_ui : StrategyUI

var fighter_dice : Array[dice]
var opponent_dice : Array[dice]

func start_battle(opponent : OpponentStats):
	opponent_stats = opponent
	
	show()
	
	initialise()

func initialise():
	generate_opponents_strategy()
	get_fighters_strategy()

func generate_opponents_strategy():
	for i in range(opponent_stats.stamina):
		var random_type : dice.DiceType = randi_range(0,2) as dice.DiceType
		var sides = 0
		match random_type:
			dice.DiceType.Aggro:
				sides = opponent_stats.max_aggro
			dice.DiceType.Endurance:
				sides = opponent_stats.max_endurance
			dice.DiceType.Agility:
				sides = opponent_stats.max_agility
		var new_die = dice.new(sides, random_type)
		new_die.value = randi_range(0, new_die.sides)
		opponent_dice.append(new_die)

func get_fighters_strategy():
	for type in FighterStats.strategy:
		var sides = 0
		match type:
			dice.DiceType.Aggro:
				sides = FighterStats.aggro_max
			dice.DiceType.Endurance:
				sides = FighterStats.endurance_max
			dice.DiceType.Agility:
				sides = FighterStats.agility_max
		var new_die = dice.new(sides, type)
		new_die.value = randi_range(0, new_die.sides)
		fighter_dice.append(new_die)
