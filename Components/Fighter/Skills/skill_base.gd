@abstract
class_name Skill
extends Resource

enum TargetType { NONE, FINITE_DICE, ALL_DICE }
@export var target_target : TargetType
@export var target_amount : int
enum TargetAffiliation { SELF, OPPONENT, BOTH }
@export var target_affiliation : TargetAffiliation
enum Frequency { ALWAYS, PERROUND, PERCOMBAT }
@export var frequency : Frequency

@abstract func on_skill_apply(br : BattleRefs, targets : Array = [])
