extends BattlePhase

func enter_phase(br : BattleRefs):
	br.your_dice = get_fighters_strategy(FighterStats.stats)
	br.opponent_dice = get_fighters_strategy(Stats.new())
	
	br.your_strategy.update_strategy_from_dice(br.your_dice)
	br.opponents_strategy.update_strategy_from_dice(br.opponent_dice)

func exit_phase(_br : BattleRefs):
	pass

func update_phase(_br : BattleRefs, _delta : float):
	transition.emit("PlanningPhase")

func get_fighters_strategy(stats : Stats) -> Array[dice]:
	var fighter_dice : Array[dice]
	for type in FighterStats.stats.strategy:
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
