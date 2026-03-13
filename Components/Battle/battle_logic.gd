extends Control

signal battle_finished(result : int)

@onready var battle_manager : BattleManager = $BattleManager
@onready var battle_refs : BattleRefs = $BattleRefs

func _ready() -> void:
	battle_refs.results_screen.close_button.pressed.connect(finish_battle)

func start_battle():
	show()
	battle_manager.transition_phase("StartPhase")

func finish_battle():
	hide()
	battle_finished.emit(1)
