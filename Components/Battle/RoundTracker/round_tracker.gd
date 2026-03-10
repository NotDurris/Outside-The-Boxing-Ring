class_name RoundTracker
extends VBoxContainer

const DEFAULT_COLOUR : Color = Color(0.191, 0.191, 0.191, 1.0)
const GREEN_COLOUR : Color = Color(0.0, 0.94, 0.242, 1.0)
const RED_COLOUR : Color = Color(1.0, 0.228, 0.379, 1.0)
const BLUE_COLOUR : Color = Color(0.0, 0.68, 0.92, 1.0)

const round_count_to_string : Array = ["ROUND ONE", "ROUND TWO", "FINAL ROUND"]

@onready var round_label : Label = $RoundLabel
@onready var round_dots : Array = [$DotsIndicators/DotOne, $DotsIndicators/DotTwo, $DotsIndicators/DotThree]

func update_visual(round_count : int, results : Array[int]):
	round_label.text = round_count_to_string[round_count]
	
	for i in range(results.size()):
		var target_dot : Panel = round_dots[i]
		var target_stylebox : StyleBoxFlat = target_dot.get_theme_stylebox("panel") as StyleBoxFlat
		if results[i] > 0:
			# Won
			target_stylebox.bg_color = GREEN_COLOUR
		elif results[i] < 0:
			# Lost
			target_stylebox.bg_color = RED_COLOUR
		else:
			# Tied
			target_stylebox.bg_color = BLUE_COLOUR
