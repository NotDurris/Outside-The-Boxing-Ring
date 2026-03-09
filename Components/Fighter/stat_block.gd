extends Control

@export var dice_type : dice.DiceType

@onready var label : Label = $Label

func _ready() -> void:
	match(dice_type):
		dice.DiceType.Aggro:
			label.text = str(FighterStats.aggro_max)
			FighterStats.aggro_max_updated.connect(func(value) : label.text = str(value))
		dice.DiceType.Endurance:
			label.text = str(FighterStats.endurance_max)
			FighterStats.endurance_max_updated.connect(func(value) : label.text = str(value))
		dice.DiceType.Agility:
			label.text = str(FighterStats.agility_max)
			FighterStats.agility_max_updated.connect(func(value) : label.text = str(value))
