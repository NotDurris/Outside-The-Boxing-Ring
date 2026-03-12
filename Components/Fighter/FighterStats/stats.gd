class_name Stats
extends Resource

var aggro_max : int = 6
var endurance_max : int = 6
var agility_max : int = 6
var reputation : int = 3
var stamina : int = 5
var mental : int = 3
var strategy : Array[dice.DiceType] = [dice.DiceType.Aggro , dice.DiceType.Endurance , dice.DiceType.Agility]

var skills : Array[Skill]
var traits : Array[Trait]
