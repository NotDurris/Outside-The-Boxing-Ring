extends Control

signal battle_finished(result : int)

var current_phase : Phase
enum Phase {Planning, Execution, Resolution}

var opponent_stats : OpponentStats

@export_group("Dependencies")
@export var fight_button : Button
@export var round_tracker : RoundTracker
@export var fighter_strategy_ui : StrategyUI
@export var opponent_strategy_ui : StrategyUI
@export var your_dice_slot : Control
@export var opponent_dice_slot : Control
@export var your_score_label : Label
@export var opponent_score_label : Label
@export var results_screen : ResultsScreen

var fighter_dice : Array[dice]
var opponent_dice : Array[dice]

@onready var battle_manager : BattleManager = $BattleManager

func _ready() -> void:
	results_screen.close_button.pressed.connect(finish_battle)
	
	# Generate Battle Refs
	var new_br : BattleRefs = BattleRefs.new(fight_button, round_tracker, results_screen,
											fighter_strategy_ui, opponent_strategy_ui, 
											your_dice_slot, opponent_dice_slot, 
											your_score_label, opponent_score_label)
	battle_manager.battle_refs = new_br
	
	start_battle()

func start_battle():
	show()
	battle_manager.transition_phase("StartPhase")

func finish_battle():
	hide()
	battle_finished.emit(1)
