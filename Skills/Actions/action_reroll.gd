extends SkillAction

func do_action(_br : BattleRefs, targets : Array[dice]):
	for target in targets:
		target.roll()
