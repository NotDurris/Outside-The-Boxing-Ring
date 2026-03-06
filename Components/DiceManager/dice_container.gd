@tool
extends Container

@export var margin : float = 8
@export var spacing : float = 4

const DICE_SIZE : float = 64

var y_count : int = 0
var x_count : int = 0

func _ready() -> void:
	queue_sort()

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		var current_count = Vector2i.ZERO
		
		var available_space = get_parent().size.x - (2 * margin)
		
		var x = (available_space - DICE_SIZE) / (DICE_SIZE + spacing) - 1
		
		for c : Control in get_children():
			c.position = current_count * (DICE_SIZE + spacing) + Vector2.ONE * margin
			if current_count.x >= x:
				current_count.x = 0
				current_count.y += 1
			else:
				current_count.x += 1
		
		y_count = current_count.y
		x_count = current_count.x
		update_minimum_size()
		
		for c : Control in get_children():
			c.size = c.get_minimum_size()

func _get_minimum_size() -> Vector2:
	var x_min = x_count * (DICE_SIZE + spacing) + DICE_SIZE + margin * 2
	var y_min = y_count * (DICE_SIZE + spacing) + DICE_SIZE + margin * 2
	return Vector2(x_min, y_min)
