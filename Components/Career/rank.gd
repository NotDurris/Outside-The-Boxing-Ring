extends VBoxContainer

@export var rank : int
@export var colour : Color

@onready var rank_label: Label = $Level/RankLabel 
@onready var background: ColorRect = $Boss/Background

func _ready() -> void:
	rank_label.text = str(rank)
	background.color = colour
