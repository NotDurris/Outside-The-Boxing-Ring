extends Node

@onready var button : Button = get_parent()
var hovered : bool = false

@onready var tweener : Tween

var pitches = [0.9,0.95,1.0,1.05,1.1]
var current_pitch = 0 :
	set(value):
		if value > pitches.size()-1:
			value -= pitches.size()
		current_pitch = value

func _ready() -> void:
	button.pivot_offset = button.size * 0.5
	button.connect("button_down", on_pressed)
	button.connect("mouse_entered", on_entered)
	button.connect("mouse_exited", on_exited)

func on_pressed():
	if !is_inside_tree() or get_parent().disabled == true:
		return
	if tweener != null:
		tweener.kill()
	tweener = create_tween()
	var grow = create_tween()
	grow.tween_property(get_parent(), "scale", Vector2.ONE * 0.92, 0.1)
	tweener.set_loops()
	tweener.set_trans(Tween.TRANS_BOUNCE)
	tweener.set_ease(Tween.EASE_IN_OUT)
	tweener.tween_property(get_parent(), "rotation", -0.02, 0.2)
	tweener.tween_property(get_parent(), "rotation", 0.02, 0.2)
	current_pitch += 1
	AudioManager.play_sound("ButtonClick", pitches[current_pitch])

func on_entered():
	if !is_inside_tree() or get_parent().disabled == true:
		return
	if tweener != null:
		tweener.kill()
	tweener = create_tween()
	var grow = create_tween()
	grow.tween_property(get_parent(), "scale", Vector2.ONE * 1.05, 0.2)
	tweener.set_loops()
	tweener.set_trans(Tween.TRANS_BOUNCE)
	tweener.set_ease(Tween.EASE_IN_OUT)
	tweener.tween_property(get_parent(), "rotation", -0.05, 0.2)
	tweener.tween_property(get_parent(), "rotation", 0.05, 0.2)
	AudioManager.play_sound("ButtonHover", pitches[current_pitch])

func on_exited():
	if !is_inside_tree() or get_parent().disabled == true:
		return
	if tweener != null:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(get_parent(), "rotation", 0, 0.1)
	tweener.tween_property(get_parent(), "scale", Vector2.ONE, 0.1)
