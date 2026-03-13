class_name RoundTracker
extends VBoxContainer

const round_count_to_string : Array = ["ROUND ONE", "ROUND TWO", "FINAL ROUND"]

@onready var round_label : Label = $RoundLabel
@onready var round_dots : Array[Dot] = [$DotsIndicators/Dot, $DotsIndicators/Dot2, $DotsIndicators/Dot3]

var results : Array[int]

func set_round_label(round_count : int):
	round_label.text = round_count_to_string[round_count]

func reset():
	for target_dot in round_dots:
		target_dot.set_colour(Dot.GREY_COLOUR)

func set_dot_indicator(round_count : int, result : int):
	var target_dot : Dot = round_dots[round_count]
	if result > 0:
		# Won
		target_dot.set_colour(Dot.GREEN_COLOUR)
	elif result < 0:
		# Lost
		target_dot.set_colour(Dot.RED_COLOUR)
	else:
		# Tied
		target_dot.set_colour(Dot.BLUE_COLOUR)
