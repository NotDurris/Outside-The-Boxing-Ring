class_name  SkillManager
extends PanelContainer

@export var skill_buttons : Array[Button]
var button_disabled : Array[bool] = [false, false, false, false]
var skill_dots : Array[Dot]
const DOT = preload("uid://g8fptfm0a2ey")

@export_group("Dependencies")
@export var dots_container : Control
@export var selection_pop_up : Control
@export var selection_pop_up_label : Label
@export var selection_pop_up_button : Button

var selected_dice : Array[int]
var select_amount : int


func _ready() -> void:
	for i in range(skill_buttons.size()):
		skill_buttons[i].pressed.connect(func() : skill_selected(i))

func initiate_skills():
	for dot in skill_dots:
		dot.queue_free()
	skill_dots.clear()
	for i in range(YourFighter.stats.mental):
		var new_dot : Dot = DOT.instantiate()
		skill_dots.append(new_dot)
		dots_container.add_child(new_dot)
	
	for i in range(skill_buttons.size()):
		var target_button : Button = skill_buttons[i]
		if i < YourFighter.skills.size() and YourFighter.skills.size() != 0:
			button_disabled[i] = false
			target_button.disabled = button_disabled[i]
			target_button.text = YourFighter.skills[i].resource_name
		else:
			button_disabled[i] = true
			target_button.disabled = button_disabled[i]

func activate(br : BattleRefs):
	br.your_dice_visual.dice_selected.connect(handle_dice_selection)
	br.opponents_dice_visual.dice_selected.connect(handle_dice_selection)
	for i in range(skill_buttons.size()):
		skill_buttons[i].disabled = button_disabled[i]

func deactivate(br : BattleRefs):
	br.your_dice_visual.dice_selected.disconnect(handle_dice_selection)
	br.opponents_dice_visual.dice_selected.disconnect(handle_dice_selection)
	for button in skill_buttons:
		button.disabled = true

func skill_selected(id : int):
	var selected_skill : Skill = YourFighter.skills[id]
	
	match (selected_skill.target_type):
		Skill.TargetType.NONE:
			pass
		Skill.TargetType.FINITE_DICE:
			pass
		Skill.TargetType.ALL_DICE:
			pass

func apply_skill_effects(target_skill : Skill):
	pass

func handle_dice_selection(id : int):
	print("Dice Selected, Id is " + str(id))
