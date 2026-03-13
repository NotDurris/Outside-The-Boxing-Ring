class_name SubMenuPanel
extends UIPanel

func _ready() -> void:
	super._ready()
	GlobalSignals.open_pop_up_menu.connect(open_and_change_contents)
	GlobalSignals.close_pop_up_menu.connect(close_panel)

func open_and_change_contents(new_contents : PackedScene):
	var instanced_contents : SubMenu = new_contents.instantiate()
	if content_container.get_children().size() > 0 : content_container.get_child(0).queue_free()
	
	panel_title = instanced_contents.title
	
	title_label.text = panel_title
	content_container.add_child(instanced_contents)
	
	open_panel()
