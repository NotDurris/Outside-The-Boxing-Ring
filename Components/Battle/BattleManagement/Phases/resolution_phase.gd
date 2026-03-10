extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = true

func exit_phase(_br : BattleRefs):
	pass

func update_phase(_br : BattleRefs, _delta : float):
	pass
