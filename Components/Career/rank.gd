class_name Rank
extends Control

@export_group("Rank Settings")
@export var rank : int
@export var colour : Color
@export var locked : bool = true

@onready var event_container : Container = $RankContents/Level/Container

@export_group("Dependencies")
@export var rank_label: Label
@export var background: ColorRect
@export var lock_screen: Control

func _ready() -> void:
	rank_label.text = str(rank)
	background.color = colour
	lock_screen.visible = locked
