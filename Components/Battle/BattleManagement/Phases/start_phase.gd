extends BattlePhase

func enter_phase(br : BattleRefs):
	# Initiate Skills
	br.skill_manager.initiate_skills(br)
	
	# Generate Fighters
	br.you = Fighter.new(YourFighter.stats)
	var op_stats : Stats = Stats.new()
	#op_stats.strategy.append_array([dice.DiceType.Aggro, dice.DiceType.Endurance, dice.DiceType.Agility, dice.DiceType.Aggro, dice.DiceType.Endurance, dice.DiceType.Agility, dice.DiceType.Aggro, dice.DiceType.Endurance, dice.DiceType.Agility])
	br.opponent = Fighter.new(op_stats)
	
	br.you.available_dice = get_fighters_dice(br.you.stats)
	br.opponent.available_dice = get_fighters_dice(br.opponent.stats)
	
	br.your_dice_visual.update_target_fighter(br.you)
	br.opponents_dice_visual.update_target_fighter(br.opponent)

func exit_phase(_br : BattleRefs):
	pass

func update_phase(_br : BattleRefs, _delta : float):
	transition.emit("PlanningPhase")

func get_fighters_dice(stats : Stats) -> Array[dice]:
	var fighter_dice : Array[dice]
	for type in stats.strategy:
		var sides = 0
		match type:
			dice.DiceType.Aggro:
				sides = stats.aggro_max
			dice.DiceType.Endurance:
				sides = stats.endurance_max
			dice.DiceType.Agility:
				sides = stats.agility_max
		var new_die = dice.new(sides, type)
		new_die.roll()
		fighter_dice.append(new_die)
	return fighter_dice
