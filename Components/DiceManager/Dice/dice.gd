class_name dice

signal die_rolled()
signal type_changed()
signal value_set()
signal value_modified(diff : int)
signal die_set()

var value : int
var type : DiceType
var sides : int

enum DiceType {Aggro, Endurance, Agility}

func _init(new_sides : int, new_type : DiceType, new_value : int = 1):
	sides = new_sides
	type = new_type
	value = new_value

func set_dice(new_dice : dice):
	value = new_dice.value
	type = new_dice.type
	sides = new_dice.sides
	die_set.emit()

func roll():
	value = randi_range(1, sides)
	die_rolled.emit()

func set_type(new_type : DiceType):
	type = new_type
	type_changed.emit()

func set_value(new_value : int):
	value = new_value
	value_set.emit()

func modify_value(diff : int):
	value += diff
	value_modified.emit(diff)
