class_name UIDice
extends Button

const AGGRO_COLOUR = Color("#ff7661")
const ENDURANCE_COLOUR = Color("#ffbb50")
const AGILITY_COLOUR = Color("#22ffa2")
const TYPELESS_COLOUR = Color("#7f7f7f")
const DEFAULT_COLOUR = Color(1.0, 1.0, 1.0, 1.0)

const type_to_colour : Dictionary[dice.DiceType, Color] = {
	dice.DiceType.Aggro : AGGRO_COLOUR,
	dice.DiceType.Endurance : ENDURANCE_COLOUR, 
	dice.DiceType.Agility : AGILITY_COLOUR,
}

@onready var dice_visual : Control = $DiceVisual
@onready var background_panel : Control = $DiceVisual/background
@onready var value_label : Control = $DiceVisual/value
@onready var dice_animation : AnimationPlayer = $AnimationPlayer
@onready var dice_outline : Control = $DiceVisual/outline

var target_dice : dice :
	set(value):
		target_dice = value
		set_dice(value)
		target_dice.die_rolled.connect(func() : dice_animation.play("roll"))
		target_dice.die_set.connect(func() : dice_animation.play("pop"))
		target_dice.type_changed.connect(animate_colour_change)
		target_dice.die_select_changed.connect(func(selected) :
			if selected:
				dice_outline.self_modulate = Color.CORNSILK
			else:
				dice_outline.self_modulate = Color.BLACK
		)

var target_scale : float = 16 :
	set(value):
		target_scale = value
		custom_minimum_size = Vector2.ONE * target_scale
		value_label.add_theme_font_size_override("font_size", roundi(target_scale * 0.5))
		update_minimum_size()
		pivot_offset = Vector2.ONE * target_scale * 0.5

func set_dice(new_dice : dice):
	set_dice_visual(new_dice.type, str(new_dice.value))

func set_dice_visual(new_type : dice.DiceType, label : String):
	set_dice_text(label)
	set_dice_background(new_type)

func set_dice_text(label : String):
	value_label.text = label

func set_dice_background(new_type : dice.DiceType):
	background_panel.self_modulate = type_to_colour[new_type]

func set_random_value():
	set_dice_text(str(randi_range(1, target_dice.value)))

func reset_value_and_type():
	reset_value()
	reset_type()

func reset_value():
	set_dice_text(str(target_dice.value))

func reset_type():
	set_dice_background(target_dice.type)

func animate_colour_change():
	var tweener : Tween = create_tween()
	tweener.tween_property(background_panel, "self_modulate", type_to_colour[target_dice.type], 0.5)
