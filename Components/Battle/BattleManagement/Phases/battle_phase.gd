@abstract
class_name BattlePhase
extends Node

@warning_ignore("unused_signal")
signal transition(target_phase_name : String)

@abstract
func enter_phase(br : BattleRefs)

@abstract
func exit_phase(br : BattleRefs)

@abstract
func update_phase(br : BattleRefs, delta : float)
