extends BattlePhase

var score_manager : ScoreManager

var your_score : int
var opponent_score : int

func enter_phase(br : BattleRefs):
	your_score = 0
	opponent_score = 0
	if not score_manager : score_manager = ScoreManager.new()
	var your_dices : Array[UIDice] = br.your_dice_visual.ui_dice_instances
	var opponent_dices : Array[UIDice] = br.opponents_dice_visual.ui_dice_instances
	var your_strategy_count : int = your_dices.size()
	var opponent_strategy_count : int = opponent_dices.size()
	var max_count : int = max(your_strategy_count, opponent_strategy_count)
	
	br.opponents_dice_visual.process_mode = Node.PROCESS_MODE_DISABLED
	
	# Create Tweener
	var tweener : Tween = create_tween()
	tweener.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK).set_parallel()
	
	#Move Dice to there positions
	for i in range(max_count):
		if i < your_strategy_count: 
			tweener.tween_property(your_dices[i], "global_position", br.your_dice_slot.global_position, 0.2)
			tweener.tween_property(your_dices[i], "scale", your_dices[i].scale * (64.0 / your_dices[i].size.x), 0.1)
		if i < opponent_strategy_count: 
			tweener.tween_property(opponent_dices[i], "global_position", br.opponent_dice_slot.global_position, 0.2)
			tweener.tween_property(opponent_dices[i], "scale", opponent_dices[i].scale * (64.0 / opponent_dices[i].size.x), 0.1)
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
	tweener.tween_callback(func() : transition.emit("EvaluationPhase"))

func exit_phase(br : BattleRefs):
	# Reset
	score_manager = null
	
	scale_strategy_dice(br.your_dice_visual)
	scale_strategy_dice(br.opponents_dice_visual)
	
	# Updating Score
	var compare_scores : int =  your_score - opponent_score
	if compare_scores > 0:
		br.you.wins += 1
	elif compare_scores < 0:
		br.opponent.wins += 1
	
	# Update round count
	br.round_tracker.set_dot_indicator(clampi(br.current_round,0,2), compare_scores)
	br.current_round += 1
	

func update_phase(_br : BattleRefs, _delta : float):
	pass

func scale_strategy_dice(target_strategy : DiceContainer):
	target_strategy.queue_sort()
	await target_strategy.sort_children
	for die in target_strategy.ui_dice_instances:
		die.scale = Vector2.ZERO

func update_scores(id : int, br : BattleRefs):
	if not score_manager : return
	
	var result : Vector2i = score_manager.calculate_individual_score(id, br.you.available_dice, br.opponent.available_dice)
	
	your_score += result.x
	opponent_score += result.y
	
	br.your_score_label.text = str(your_score)
	br.opponent_score_label.text = str(opponent_score)
