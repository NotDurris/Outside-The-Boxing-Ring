extends SkillAction

func do_action(_br : BattleRefs, targets : Array[dice]):
	var first_die : dice = targets[0]
	var second_die : dice = targets[1]
	
	var middle_man_die : dice = dice.new(first_die.sides, first_die.type)
	middle_man_die.value = first_die.value 
	
	first_die.value = second_die.value
	first_die.sides = second_die.sides
	first_die.type = second_die.type
	
	second_die.value = middle_man_die.value
	second_die.sides = middle_man_die.sides
	second_die.type = middle_man_die.type
