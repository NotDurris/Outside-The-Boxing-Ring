extends Control

func _ready() -> void:
	mouse_entered.connect(on_hover)
	mouse_exited.connect(on_unhover)

func on_hover():
	var tweener : Tween = create_tween()
	tweener.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tweener.tween_property(self, "size_flags_stretch_ratio", 2.0, 0.1)

func on_unhover():
	var tweener : Tween = create_tween()
	tweener.tween_property(self, "size_flags_stretch_ratio", 1.0, 0.1)
