extends Button

@export var target_ui_panel : UIPanel

@export var title : String
@export var contents : PackedScene

func _ready() -> void:
	pressed.connect(func() : target_ui_panel.open_and_change_contents(title, contents))
