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
	var typal_bonus : Vector2i = Vector2i.ZERO
	if opponent_dice != null and your_dice != null:
		typal_bonus = matchup_table[your_dice.type][opponent_dice.type]
	
	# Add Scores
	var your_value : int = your_dice.value if your_dice != null else 0
	var opponent_value : int = opponent_dice.value if opponent_dice != null else 0
	result = Vector2i(your_value, opponent_value) + typal_bonus
	
	return result
