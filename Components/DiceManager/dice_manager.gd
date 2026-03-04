extends Node

var dice_array : Array[dice]

func create_dice(sides : int, type : dice.DiceType):
	dice_array.append(dice.new(sides, type))
