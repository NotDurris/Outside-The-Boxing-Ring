class_name UIDice
extends Button

const AGGRO_COLOUR = Color("#ff7661")
const ENDURANCE_COLOUR = Color("#ffbb50")
const AGILITY_COLOUR = Color("#22ffa2")
const TYPELESS_COLOUR = Color("#7f7f7f")
const DEFAULT_COLOUR = Color(1.0, 1.0, 1.0, 1.0)

var target_dice : dice :
	set(value):
		target_dice = value
		set_dice(value)
		target_dice.die_rolled.connect(func() : dice_animation.play("roll"))

var value : int :
	set(new_value):
		value = new_value
		set_dice_text(str(value))

var type : dice.DiceType :
	set(value):
		type = value
		set_dice_background(type)

var target_scale : float = 16 :
	set(value):
		target_scale = value
		custom_minimum_size = Vector2.ONE * target_scale
		value_label.add_theme_font_size_override("font_size", roundi(target_scale * 0.5))
		update_minimum_size()
		pivot_offset = Vector2.ONE * target_scale * 0.5

@onready var background_panel : Control = $background
@onready var value_label : Control = $value
@onready var dice_animation : AnimationPlayer = $AnimationPlayer

func set_dice(new_dice : dice):
	set_dice_visual(new_dice.type, str(new_dice.value))

func set_dice_visual(new_type : dice.DiceType, label : String):
	set_dice_text(label)
	set_dice_background(new_type)

func set_dice_text(label : String):
	value_label.text = label

func set_dice_background(new_type : dice.DiceType):
	match(new_type):
		dice.DiceType.Aggro:
			background_panel.self_modulate = AGGRO_COLOUR
		dice.DiceType.Endurance:
			background_panel.self_modulate = ENDURANCE_COLOUR
		dice.DiceType.Agility:
			background_panel.self_modulate = AGILITY_COLOUR
		_:
			background_panel.self_modulate = DEFAULT_COLOUR

func _ready() -> void:
	target_scale = 16

func reset_value():
	if target_dice :
		set_dice_text(str(target_dice.value))
	else:
		set_dice_text("?")
	

func set_random_value():
	if target_dice:
		value_label.text = str(randi_range(1, target_dice.sides))
	else:
		value_label.text = str(randi_range(1, 6))
