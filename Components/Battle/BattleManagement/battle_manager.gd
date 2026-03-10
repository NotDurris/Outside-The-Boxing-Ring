class_name BattleManager
extends Node

@export var initial_phase : BattlePhase
var current_phase : BattlePhase
var phases : Dictionary = {}

var battle_refs : BattleRefs

func _ready():
	for child in get_children():
		if child is BattlePhase:
			phases[child.name.to_lower()] = child
			child.transition.connect(transition_phase)

	#if initial_phase:
		#initial_phase.enter_phase(battle_refs)
		#current_phase = initial_phase

func _process(delta):
	if current_phase:
		current_phase.update_phase(battle_refs, delta)

func transition_phase(new_phase_name : String):
	print("------------- TRANSITION -------------")
	var new_phase = phases.get(new_phase_name.to_lower())
	if !new_phase or new_phase == current_phase:
		return

	if current_phase :
		print("Phase Exited: " + current_phase.name) 
		current_phase.exit_phase(battle_refs)
	print("Phase Entered: " + new_phase.name) 
	new_phase.enter_phase(battle_refs)
	current_phase = new_phase
	print(current_phase.name)
	print("---------------------------------")
