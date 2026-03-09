extends Node

var aggro_max : int = 6 :
	set(value):
		aggro_max_updated.emit(value)
		aggro_max = value
@warning_ignore("unused_signal")
signal aggro_max_updated(new_aggro : int)

var endurance_max : int = 6 :
	set(value):
		endurance_max_updated.emit(value)
		endurance_max = value
@warning_ignore("unused_signal")
signal endurance_max_updated(new_endurance : int)

var agility_max : int = 6 :
	set(value):
		agility_max_updated.emit(value)
		agility_max = value
@warning_ignore("unused_signal")
signal agility_max_updated(new_agility : int)

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
