extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = false
	
	if br.current_round > 2:
		# final round
		br.fight_btn.text = "CONCLUDE"
		br.fight_btn.pressed.connect(finish_fight)
	else:
		# continue
		br.fight_btn.text = "CONTINUE"
		br.fight_btn.pressed.connect(continue_fight)

func exit_phase(br : BattleRefs):
	br.fight_btn.disabled = true
	br.your_score_label.text = "0"
	br.opponent_score_label.text = "0"
	br.round_tracker.set_round_label(clamp(br.current_round, 0, 2))
	
	if br.current_round > 2:
		# final round
		br.fight_btn.pressed.disconnect(finish_fight)
	else:
		# continue
		br.fight_btn.pressed.disconnect(continue_fight)


func update_phase(_br : BattleRefs, _delta : float):
	pass

func continue_fight():
	transition.emit("PlanningPhase")

func finish_fight():
	transition.emit("ResolutionPhase")
