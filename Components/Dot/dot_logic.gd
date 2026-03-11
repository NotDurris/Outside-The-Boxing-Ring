class_name Dot
extends Control

const GREY_COLOUR : Color = Color(0.208, 0.208, 0.208, 1.0)
const WHITE_COLOUR : Color = Color(0.904, 0.904, 0.904, 1.0)
const GREEN_COLOUR : Color = Color(0.0, 0.94, 0.242, 1.0)
const RED_COLOUR : Color = Color(1.0, 0.228, 0.379, 1.0)
const BLUE_COLOUR : Color = Color(0.0, 0.68, 0.92, 1.0)

func set_colour(colour : Color):
	self_modulate = colour
