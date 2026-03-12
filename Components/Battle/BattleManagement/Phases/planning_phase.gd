extends BattlePhase

func enter_phase(br : BattleRefs):
	br.fight_btn.disabled = false
	br.fight_btn.text = "FIGHT"
	br.fight_btn.pressed.connect(start_fight)
	
	br.your_dice_visual.scale_strategy_dice(Vector2.ONE)
	br.opponents_dice_visual.scale_strategy_dice(Vector2.ONE)
	
	br.you.available_dice = get_fighters_dice(br.you.stats)
	br.opponent.available_dice = get_fighters_dice(br.opponent.stats)
	
	br.skill_manager.activate(br)

func exit_phase(br : BattleRefs):
	br.skill_manager.deactivate(br)
	br.fight_btn.disabled = true
	br.fight_btn.pressed.disconnect(start_fight)

func update_phase(_br : BattleRefs, _delta : float):
	pass

func start_fight():
	transition.emit("FightPhase")

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
