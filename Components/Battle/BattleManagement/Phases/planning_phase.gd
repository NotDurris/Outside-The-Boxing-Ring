extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = false
	br.fight_btn.text = "FIGHT"
	br.fight_btn.pressed.connect(start_fight)
	br.skill_manager.activate(br)
	
	br.your_dice_visual.scale_strategy_dice(Vector2.ONE)
	br.opponents_dice_visual.scale_strategy_dice(Vector2.ONE)
	
	roll_all_dice(br)

func exit_phase(br : BattleRefs):
	br.skill_manager.deactivate(br)
	br.fight_btn.disabled = true
	br.fight_btn.pressed.disconnect(start_fight)

func update_phase(_br : BattleRefs, _delta : float):
	pass

func start_fight():
	transition.emit("FightPhase")

func roll_all_dice(br : BattleRefs):
	for die in br.you.available_dice:
		die.roll()
	for die in br.opponent.available_dice:
		die.roll()
	
	br.you.dice_updated.emit(br.you.available_dice)
	br.opponent.dice_updated.emit(br.opponent.available_dice)
	
	for die in br.your_dice_visual.ui_dice_instances:
		die.dice_animation.play("roll")
	for die in br.opponents_dice_visual.ui_dice_instances:
		die.dice_animation.play("roll")
