extends BattlePhase

var score_manager : ScoreManager

var your_score : int
var opponent_score : int

func enter_phase(br : BattleRefs):
	your_score = 0
	opponent_score = 0
	if not score_manager : score_manager = ScoreManager.new()
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
		tweener.chain().tween_interval(0.0)
		if i < your_strategy_count:
			tweener.tween_property(your_dices[i], "global_position", br.your_dice_slot.global_position + Vector2.RIGHT * 16, 0.1)
			tweener.tween_property(your_dices[i], "scale", Vector2.ZERO, 0.2)
		if i < opponent_strategy_count:
			tweener.tween_property(opponent_dices[i], "global_position", br.opponent_dice_slot.global_position + Vector2.LEFT * 16, 0.1)
			tweener.tween_property(opponent_dices[i], "scale", Vector2.ZERO, 0.2)
		tweener.chain().tween_interval(0.2)
		tweener.tween_callback(func() : update_scores(i, br))
	
	tweener.chain().tween_interval(0.1)
	tweener.tween_callback(func() :
		if br.current_round >= 2 :
			transition.emit("ResolutionPhase")
		else:
			transition.emit("PlanningPhase")
	)

func exit_phase(br : BattleRefs):
	score_manager = null
	
	br.your_strategy.queue_sort()
	br.opponents_strategy.queue_sort()
	
	br.your_score_label.text = "0"
	br.opponent_score_label.text = "0"
	
	br.round_results.append(your_score - opponent_score)
	br.current_round += 1
	if br.current_round <= 2 :
		br.round_tracker.update_visual(br.current_round, br.round_results)
	else:
		br.round_tracker.update_visual(2, br.round_results)
	
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

func update_scores(id : int, br : BattleRefs):
	if not score_manager : return
	
	var result : Vector2i = score_manager.calculate_individual_score(id, br.your_dice, br.opponent_dice)
	
	your_score += result.x
	opponent_score += result.y
	
	br.your_score_label.text = str(your_score)
	br.opponent_score_label.text = str(opponent_score)
