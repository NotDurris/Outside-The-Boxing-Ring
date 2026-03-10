extends BattlePhase

func enter_phase(br : BattleRefs):
	# Generate Fighters
	br.you = Fighter.new(YourFighter.stats, YourFighter.skills, YourFighter.traits)
	br.opponent = Fighter.new(Stats.new())
	
	br.you.available_dice = get_fighters_dice(br.you.stats)
	br.opponent.available_dice = get_fighters_dice(br.opponent.stats)
	
	br.your_strategy.update_strategy_from_dice(br.you.available_dice)
	br.opponents_strategy.update_strategy_from_dice(br.opponent.available_dice)

func exit_phase(_br : BattleRefs):
	pass

func update_phase(_br : BattleRefs, _delta : float):
	transition.emit("PlanningPhase")

func get_fighters_dice(stats : Stats) -> Array[dice]:
	var fighter_dice : Array[dice]
	for type in YourFighter.stats.strategy:
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
