class_name BattleRefs

var fight_btn : Button
var your_dice : Array[dice]
var opponent_dice : Array[dice]
var your_strategy : StrategyUI
var opponents_strategy : StrategyUI
var your_dice_slot : Control
var opponent_dice_slot : Control

func _init(new_fight_btn : Button, 
		new_your_strategy : StrategyUI, 
		new_opponents_strategy : StrategyUI,
		new_your_dice_slot : Control,
		new_opponent_dice_slot : Control):
	fight_btn = new_fight_btn
	your_strategy = new_your_strategy
	opponents_strategy = new_opponents_strategy
	your_dice_slot = new_your_dice_slot
	opponent_dice_slot = new_opponent_dice_slot
