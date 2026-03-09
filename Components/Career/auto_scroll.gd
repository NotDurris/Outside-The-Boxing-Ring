extends ScrollContainer

func _ready() -> void:
	var tweener : Tween = create_tween()
	tweener.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tweener.tween_interval(0.5)
	tweener.tween_property(self, "scroll_vertical", get_child(0).size.y, 3)
