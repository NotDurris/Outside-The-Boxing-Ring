class_name BattleRefs

var fight_btn : Button
var your_strategy : StrategyUI
var opponents_strategy : StrategyUI
var your_dice_slot : Control
var opponent_dice_slot : Control
var your_score_label : Label
var opponent_score_label : Label
var round_tracker : RoundTracker
var results_screen : ResultsScreen

var your_dice : Array[dice]
var opponent_dice : Array[dice]
var your_score : int
var opponent_score : int
var round_results : Array[int]
var current_round : int = 0

func reset():
	your_dice.clear()
	opponent_dice.clear()
	your_score = 0
	opponent_score = 0
	round_results.clear()
	current_round = 0

func _init(new_fight_btn : Button, new_round_tracker : RoundTracker, new_results_screen : ResultsScreen,
		new_your_strategy : StrategyUI, 
		new_opponents_strategy : StrategyUI,
		new_your_dice_slot : Control,
		new_opponent_dice_slot : Control,
		new_your_score_label : Label,
		new_opponent_score_label : Label):
	fight_btn = new_fight_btn
	round_tracker = new_round_tracker
	results_screen = new_results_screen
	your_strategy = new_your_strategy
	opponents_strategy = new_opponents_strategy
	your_dice_slot = new_your_dice_slot
	opponent_dice_slot = new_opponent_dice_slot
	your_score_label = new_your_score_label
	opponent_score_label = new_opponent_score_label
