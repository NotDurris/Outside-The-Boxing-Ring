class_name Skill
extends Resource

@export_group("Description")
@export var name : String
@export_multiline var description : String

@export_group("Settings")
enum TargetType { NONE, FINITE_DICE, ALL_DICE }
@export var target_type : TargetType
@export var target_amount : int
enum TargetAffiliation { SELF, OPPONENT, BOTH }
@export var target_affiliation : TargetAffiliation
enum Frequency { ALWAYS, PERROUND, PERCOMBAT }
@export var frequency : Frequency

@export var skill_action : Script
