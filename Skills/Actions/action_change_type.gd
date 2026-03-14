extends SkillAction

func do_action(_br : BattleRefs, targets : Array[dice]):
	for die in targets:
		var random_index = randi_range(0,1)
		if random_index >= (die.type as int):
			random_index += 1
		die.set_type(random_index as dice.DiceType)
