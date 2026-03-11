class_name Fighter

var stats : Stats
var skills : Array[Skill]
var traits : Array[Trait]

var available_dice : Array[dice] :
	set(value):
		available_dice = value
		dice_updated.emit(value)

func add_die(new_die: dice):
	available_dice.append(new_die)
	dice_updated.emit(available_dice) # Manually fire the signal

func remove_die(index: int):
	available_dice.remove_at(index)
	dice_updated.emit(available_dice) # Manually fire the signal
	

signal dice_updated(new_dice : Array[dice])


var current_score : int
var wins : int

func _init(_stats : Stats, _skills : Array[Skill] = [], _traits : Array[Trait] = []):
	stats = _stats
	skills = _skills
	traits = _traits
	
	available_dice = []
	current_score = 0
	wins = 0
