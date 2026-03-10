extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = false
	br.fight_btn.pressed.connect(start_fight)

func exit_phase(br : BattleRefs):
	br.fight_btn.disabled = true
	br.fight_btn.pressed.disconnect(start_fight)

func update_phase(_br : BattleRefs, _delta : float):
	pass

func start_fight():
	transition.emit("FightPhase")
