class_name UIDice
extends Button

@onready var background_panel : Control = $background
@onready var value_label : Control = $value

const AGGRO_BACKGROUND = preload("uid://k5a7h25xx5f3")
const ENDURANCE_BACKGROUND = preload("uid://db0ujnhteaba")
const AGILITY_BACKGROUND = preload("uid://dsujrwsu6y5ay")
const DEFAULT_BACKGROUND = preload("uid://b1hsaw56djxkx")
const EMPTY_BACKGROUND = preload("uid://chccsww0104xp")

func set_dice_visual(type : dice.DiceType, label : String):
	set_dice_text(label)
	set_dice_background(type)

func set_dice_text(label : String):
	value_label.text = label

func set_dice_background(type : dice.DiceType):
	match(type):
		dice.DiceType.Aggro:
			background_panel.add_theme_stylebox_override("panel", AGGRO_BACKGROUND)
		dice.DiceType.Endurance:
			background_panel.add_theme_stylebox_override("panel", ENDURANCE_BACKGROUND)
		dice.DiceType.Agility:
			background_panel.add_theme_stylebox_override("panel", AGILITY_BACKGROUND)
		_:
			background_panel.add_theme_stylebox_override("panel", DEFAULT_BACKGROUND)

func _ready() -> void:
	pivot_offset = size * 0.5
	background_panel.pivot_offset = background_panel.size * 0.5
	value_label.pivot_offset = value_label.size * 0.5
