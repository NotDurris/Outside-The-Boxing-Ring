@tool
extends Container

const SPACING : float = 100
const RANDOMISE_MAGNITUDE : float = 8

@export var positions : Array[Vector2]

var x_count : int = 0
var y_count : int = 0

var x_margin : float = 0.0
var y_margin : float = 0.0

func _ready() -> void:
	positions.clear()
	_notification(NOTIFICATION_SORT_CHILDREN)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL

func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		x_count = floori(size.x / SPACING) - 2
		y_count = floori(size.y / SPACING) - 2
		
		x_margin = (size.x - float(x_count * SPACING)) * 0.5 / SPACING
		y_margin = (size.y - float(y_count * SPACING)) * 0.5 / SPACING
		
		
	if what == NOTIFICATION_SORT_CHILDREN:
		var children : Array[Node]
		children = get_children()
		
		for i in range(children.size()):
			if x_count * y_count <= positions.size(): return
			var new_position = Vector2i(randi_range(0, x_count), randi_range(0, y_count))
			while positions.has(new_position):
				var x_bounce := randi_range(0,1)
				var y_bounce := randi_range(0,1) if x_bounce == 1 else 1
				new_position += Vector2i(x_bounce, y_bounce)
				if new_position.x > x_count:
					new_position.x = 0
				if new_position.y > y_count:
					new_position.y = 0
			positions.append(new_position)
			var random_shift := Vector2(randf()*2 - 1, randf()*2 - 1) * RANDOMISE_MAGNITUDE
			children[i].position = (Vector2(new_position) + Vector2(x_margin, y_margin)) * SPACING + random_shift
