class_name UIPanel
extends Control

signal on_panel_close_button_clicked
signal on_panel_closed
signal on_panel_opened

@export var panel_title : String
@export var panel_contents : PackedScene

@export_group("Panel Animation Settings")
@export_subgroup("open")
@export var show_duration : float = 0.4
@export var show_tween_trans : Tween.TransitionType = Tween.TRANS_BACK
@export var show_tween_ease : Tween.EaseType = Tween.EASE_OUT

@export_subgroup("close")
@export var hide_duration : float = 0.3
@export var hide_tween_trans : Tween.TransitionType = Tween.TRANS_BACK
@export var hide_tween_ease : Tween.EaseType = Tween.EASE_IN

@export_group("Elements")
@export var title_label : Label
@export var background : ColorRect
@export var foreground : Control
@export var close_button : Button
@export var content_container : Control

var background_colour : Color

func _ready() -> void:
	title_label.text = panel_title
	background_colour = background.color
	
	close_button.pressed.connect(func() : on_panel_close_button_clicked.emit())
	on_panel_close_button_clicked.connect(close_panel)
	
	initialise_layout()
	hide()

func initialise_layout():
	set_anchor_and_offset(SIDE_RIGHT, 1.0, 0)
	set_anchor_and_offset(SIDE_BOTTOM, 1.0, 0)
	set_anchor_and_offset(SIDE_LEFT, 0.0, 0)
	set_anchor_and_offset(SIDE_TOP, 0.0, 0)
	foreground.pivot_offset = size * 0.5
	
	if panel_contents == null : return
	
	var instanced_contents = panel_contents.instantiate()
	content_container.add_child(instanced_contents)

func open_and_change_contents(new_title : String, new_contents : PackedScene):
	if content_container.get_children().size() > 0 : content_container.get_child(0).queue_free()
	
	panel_contents = new_contents
	panel_title = new_title
	
	title_label.text = panel_title
	var instanced_contents = panel_contents.instantiate()
	content_container.add_child(instanced_contents)
	
	open_panel()

func open_panel():
	show()
	foreground.scale = Vector2.ZERO
	if show_duration == 0:
		foreground.scale = Vector2.ONE
		background.color = background_colour
		on_panel_opened.emit()
		return
	var tweener = create_tween()
	tweener.set_trans(show_tween_trans).set_ease(show_tween_ease).set_parallel()
	tweener.tween_property(foreground, "scale", Vector2.ONE, show_duration)
	tweener.tween_property(background, "color", background_colour, show_duration * 0.5)
	tweener.chain().tween_callback(on_panel_opened.emit)

func close_panel():
	if show_duration == 0:
		foreground.scale = Vector2.ZERO
		background.color = Color(background_colour, 0.0)
		on_panel_closed.emit()
		return
	
	var tweener = create_tween()
	tweener.set_trans(hide_tween_trans).set_ease(hide_tween_ease).set_parallel()
	tweener.tween_property(foreground, "scale", Vector2.ZERO, hide_duration)
	tweener.tween_property(background, "color", Color(background_colour, 0.0), hide_duration * 1.2)
	tweener.chain().tween_callback(hide)
	tweener.chain().tween_callback(on_panel_closed.emit)
