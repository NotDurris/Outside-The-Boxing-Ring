extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = false
	br.fight_btn.text = "FIGHT"
	br.fight_btn.pressed.connect(start_fight)
	
	scale_strategy_dice(br.your_strategy)
	scale_strategy_dice(br.opponents_strategy)
	
	roll_all_dice(br)

func exit_phase(br : BattleRefs):
	br.fight_btn.disabled = true
	br.fight_btn.pressed.disconnect(start_fight)

func update_phase(_br : BattleRefs, _delta : float):
	pass

func start_fight():
	transition.emit("FightPhase")

func scale_strategy_dice(target_strategy : StrategyUI):
	var tweener : Tween = create_tween()
	tweener.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	for die in target_strategy.ui_dice_instances:
		tweener.tween_property(die, "scale", Vector2.ONE, 0.1)

func roll_all_dice(br : BattleRefs):
	for die in br.you.available_dice:
		die.roll()
	for die in br.opponent.available_dice:
		die.roll()
	
	br.your_strategy.update_strategy_from_dice(br.you.available_dice)
	br.opponents_strategy.update_strategy_from_dice(br.opponent.available_dice)
	
	for die in br.your_strategy.ui_dice_instances:
		die.dice_animation.play("roll")
	for die in br.opponents_strategy.ui_dice_instances:
		die.dice_animation.play("roll")
