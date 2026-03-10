extends BattlePhase

func enter_phase(br : BattleRefs):
	var your_dices : Array[UIDice] = br.your_strategy.ui_dice_instances
	var opponent_dices : Array[UIDice] = br.opponents_strategy.ui_dice_instances
	var your_strategy_count : int = your_dices.size()
	var opponent_strategy_count : int = opponent_dices.size()
	var max_count : int = max(your_strategy_count, opponent_strategy_count)
	
	# Create Tweener
	var tweener : Tween = create_tween()
	tweener.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK).set_parallel()
	
	#Move Dice to there positions
	for i in range(max_count):
		if i < your_strategy_count: 
			tweener.tween_property(your_dices[i], "global_position", br.your_dice_slot.global_position, 0.2)
		if i < opponent_strategy_count: 
			tweener.tween_property(opponent_dices[i], "global_position", br.opponent_dice_slot.global_position, 0.2)
		tweener.chain().tween_interval(0.4)
		tweener.chain().tween_interval(0.1)
		if i < your_strategy_count:
			tweener.tween_property(your_dices[i], "global_position", br.your_dice_slot.global_position + Vector2.RIGHT * 16, 0.1)
			tweener.tween_property(your_dices[i], "scale", Vector2.ZERO, 0.2)
		if i < opponent_strategy_count:
			tweener.tween_property(opponent_dices[i], "global_position", br.opponent_dice_slot.global_position + Vector2.LEFT * 16, 0.1)
			tweener.tween_property(opponent_dices[i], "scale", Vector2.ZERO, 0.2)
		tweener.chain().tween_interval(0.2)
	
	tweener.chain().tween_interval(0.1)
	tweener.tween_callback(func() : transition.emit("PlanningPhase"))

func exit_phase(br : BattleRefs):
	br.your_strategy.queue_sort()
	br.opponents_strategy.queue_sort()
	for ui_dice in br.your_strategy.ui_dice_instances:
		ui_dice.scale = Vector2.ZERO
	for ui_dice in br.opponents_strategy.ui_dice_instances:
		ui_dice.scale = Vector2.ZERO
	
	# Create Tweener
	#var tweener : Tween = create_tween()
	#tweener.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK).set_parallel()
	#
	#for ui_dice in br.your_strategy.ui_dice_instances:
		#tweener.tween_property(ui_dice, "scale", Vector2.ONE, 0.6)
	#for ui_dice in br.opponents_strategy.ui_dice_instances:
		#tweener.tween_property(ui_dice, "scale", Vector2.ONE, 0.6)

func update_phase(_br : BattleRefs, _delta : float):
	pass
