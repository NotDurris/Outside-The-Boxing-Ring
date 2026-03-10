class_name ScoreManager

const matchup_table : Array = [
	#    Aggro,        Endurance,       Agility,        Typeless         
	[Vector2i(0, 0), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(2, 0)], # Aggro
	[Vector2i(-1, 1), Vector2i(0, 0), Vector2i(1, -1), Vector2i(2, 0)], # Endurance
	[Vector2i(1, -1), Vector2i(-1, 1), Vector2i(0, 0), Vector2i(2, 0)], # Agility
	[Vector2i(0, 2), Vector2i(0, 2), Vector2i(0, 2), Vector2i(0, 0)]  # Typeless
]

func calculate_score(your_strategy : Array[dice], opponent_strategy : Array[dice]) -> Vector2i:
	var result : Vector2i = Vector2i.ZERO
	var your_count : int = your_strategy.size()
	var opponent_count : int = opponent_strategy.size()
	
	for i in range(max(your_count, opponent_count)):
		result += calculate_individual_score(i, your_strategy, opponent_strategy)
	
	return result

func calculate_individual_score(index : int, your_strategy : Array[dice], opponent_strategy : Array[dice]) -> Vector2i:
	var result : Vector2i = Vector2i.ZERO
	
	var your_dice : dice
	if your_strategy.size() > index :
		your_dice = your_strategy[index]
	
	var opponent_dice : dice
	if opponent_strategy.size() > index :
		opponent_dice = opponent_strategy[index]
	
	# Apply Traits
	
	# Apply Typal Bonus
	var typal_bonus : Vector2i = matchup_table[your_dice.type][opponent_dice.type]
	
	# Add Scores
	result = Vector2i(your_dice.value, opponent_dice.value) + typal_bonus
	
	return result
