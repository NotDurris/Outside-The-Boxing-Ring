class_name dice

var value : int
var type : DiceType

var sides : int
enum DiceType {Aggro, Endurance, Agility}

func _init(new_sides : int, new_type : DiceType):
	sides = new_sides
	type = new_type
