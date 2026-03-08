extends Node

var aggro_max : int = 6
var endurance_max : int = 6
var agility_max : int = 6

var reputation : int = 3
var stamina : int = 5
var mental : int = 3

var strategy : Array[dice.DiceType] = [dice.DiceType.Aggro , dice.DiceType.Endurance , dice.DiceType.Agility]
@warning_ignore("unused_signal")
signal strategy_updated(new_strategy : Array[dice.DiceType])

func reset():
	aggro_max = 6
	endurance_max = 6
	agility_max = 6

	reputation = 3
	stamina = 5
	mental = 3
