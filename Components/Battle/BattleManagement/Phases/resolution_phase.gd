extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = true
	br.results_screen.show_results(br)
	br.round_tracker.results.clear()

func exit_phase(br : BattleRefs):
	br.results_screen.hide_results(br)
	br.round_tracker.reset()
	br.reset()

func update_phase(_br : BattleRefs, _delta : float):
	pass
