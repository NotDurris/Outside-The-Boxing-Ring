extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = true
	br.results_screen.show_results(br)

func exit_phase(br : BattleRefs):
	br.reset()

func update_phase(_br : BattleRefs, _delta : float):
	pass
