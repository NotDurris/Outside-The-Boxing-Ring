class_name BattleRefs
extends Node

var you : Fighter
var opponent : Fighter
var current_round : int = 0

@export var fight_btn : Button
@export var round_tracker : RoundTracker
@export var your_dice_visual : DiceContainer
@export var opponents_dice_visual : DiceContainer
@export var your_dice_slot : Control
@export var opponent_dice_slot : Control
@export var your_score_label : Label
@export var opponent_score_label : Label
@export var results_screen : ResultsScreen
@export var skill_manager : SkillManager

func reset():
	current_round = 0
