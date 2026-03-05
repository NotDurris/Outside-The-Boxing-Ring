extends Control

@onready var background_panel : Control = $background
@onready var value_label : Control = $value

const AGGRO_BACKGROUND = preload("uid://k5a7h25xx5f3")
const ENDURANCE_BACKGROUND = preload("uid://db0ujnhteaba")
const AGILITY_BACKGROUND = preload("uid://dsujrwsu6y5ay")
const DEFAULT_BACKGROUND = preload("uid://b1hsaw56djxkx")

var target_dice : dice :
	set(value):
		target_dice = value
		match(target_dice.type):
			dice.DiceType.Aggro:
				background_panel.add_theme_stylebox_override("panel", AGGRO_BACKGROUND)
			dice.DiceType.Endurance:
				background_panel.add_theme_stylebox_override("panel", ENDURANCE_BACKGROUND)
			dice.DiceType.Agility:
				background_panel.add_theme_stylebox_override("panel", AGILITY_BACKGROUND)
			_:
				background_panel.add_theme_stylebox_override("panel", DEFAULT_BACKGROUND)

func _ready() -> void:
	target_dice = dice.new(6, dice.DiceType.Aggro)
	pivot_offset = size * 0.5
	background_panel.pivot_offset = background_panel.size * 0.5
	value_label.pivot_offset = value_label.size * 0.5
	roll_dice_animation()

func randomise_number():
	value_label.text = str(randi_range(1, target_dice.sides))

func roll_dice_animation():
	var tweener : Tween = create_tween()
	tweener.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	var randomise_tweener : Tween = create_tween()
	randomise_tweener.set_loops()
	randomise_tweener.tween_callback(randomise_number)
	randomise_tweener.tween_interval(0.05)
	randomise_tweener.pause()
	
	tweener.tween_interval(1)
	tweener.tween_property(self, "rotation", -PI*0.1, 0.1)
	tweener.tween_callback(randomise_tweener.play)
	tweener.tween_property(self, "rotation", 2*PI, 0.3)
	
	tweener.tween_callback(func(): 
		rotation = 0
		randomise_tweener.kill()
		value_label.text = str(target_dice.value)
	)
