extends SkillAction

func do_action(_br : BattleRefs, targets : Array[dice]):
	var first_die : dice = targets[0]
	var second_die : dice = targets[1]
	
	var middle_man_die : dice = dice.new(0, dice.DiceType.Aggro)
	middle_man_die.set_dice(first_die)
	
	first_die.set_dice(second_die)
	
	second_die.set_dice(middle_man_die)
