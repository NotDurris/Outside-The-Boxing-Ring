extends Control

@onready var battle_manager : BattleManager = $BattleManager
@onready var battle_refs : BattleRefs = $BattleRefs

func _ready() -> void:
	battle_refs.results_screen.close_button.pressed.connect(finish_battle)
	GlobalSignals.start_fight.connect(start_battle)

func start_battle(opponents_stats : Stats):
	print("Starting")
	show()
	battle_refs.opponent_stats = opponents_stats
	battle_manager.transition_phase("StartPhase")

func finish_battle():
	hide()
	GlobalSignals.battle_finished.emit(battle_refs.you.wins - battle_refs.opponent.wins)
