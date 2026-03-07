@tool
extends Container

@export var margin : float = 8
@export var spacing : float = 4

const DICE_SIZE : float = 64

var y_count : int = 0
var x_count : int = 0

#func _ready() -> void:
	#queue_sort()

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		# Calculations
		var current_count = Vector2i.ZERO
		var available_space = get_parent().size.x
		var maximum_row_count = floori(available_space / DICE_SIZE)
		var spacing_size = (available_space - (maximum_row_count * DICE_SIZE)) / (maximum_row_count + 1)
		var child_count = get_children().size()
		
		# Auto sizing
		if maximum_row_count == 0 : return
		y_count = ceili(float(maximum_row_count) / child_count)
		x_count = child_count if child_count <= maximum_row_count else child_count % maximum_row_count
		update_minimum_size()
		
		# Grid Placement
		for c : Control in get_children():
			c.set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_MINSIZE)
			c.position = current_count * (DICE_SIZE + spacing_size) + Vector2.ONE * spacing_size
			if current_count.x >= (maximum_row_count - 1):
				current_count.x = 0
				current_count.y += 1
			else:
				current_count.x += 1

func _get_minimum_size() -> Vector2:
	var x_min = x_count * (DICE_SIZE + spacing) + DICE_SIZE + margin * 2
	var y_min = y_count * (DICE_SIZE + spacing) + DICE_SIZE + margin * 2
	return Vector2(x_min, y_min)
