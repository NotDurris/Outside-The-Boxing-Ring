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
@export var selection_pop_up_close : Button
@export var selection_pop_up_confirm : Button

var selected_dice : Array[dice]
var selected_skill : Skill
var battle_refs : BattleRefs

var uses_left : int :
	set(value):
		uses_left = value
		for i in range(skill_dots.size()):
			var dot : Dot = skill_dots[i]
			if i < uses_left:
				dot.set_colour(Dot.WHITE_COLOUR)
			else:
				dot.set_colour(Dot.GREY_COLOUR)

func _ready() -> void:
	selection_pop_up_close.pressed.connect(func():
		selection_pop_up.hide()
		selected_dice.clear()
		selected_skill = null
	)
	selection_pop_up_confirm.pressed.connect(apply_skill)
	for i in range(skill_buttons.size()):
		skill_buttons[i].pressed.connect(func() : skill_selected(i))

func initiate_skills(br : BattleRefs):
	battle_refs = br
	selection_pop_up.hide()
	
	for dot in skill_dots:
		dot.queue_free()
	skill_dots.clear()
	
	for i in range(YourFighter.stats.mental):
		var new_dot : Dot = DOT.instantiate()
		skill_dots.append(new_dot)
		dots_container.add_child(new_dot)
	
	for i in range(skill_buttons.size()):
		var target_button : Button = skill_buttons[i]
		if i < YourFighter.stats.skills.size() and YourFighter.stats.skills.size() != 0:
			button_disabled[i] = false
			target_button.disabled = button_disabled[i]
			target_button.text = YourFighter.stats.skills[i].name
		else:
			button_disabled[i] = true
			target_button.disabled = button_disabled[i]

func activate(br : BattleRefs):
	br.your_dice_visual.dice_selected.connect(your_dice_selection)
	br.opponents_dice_visual.dice_selected.connect(opponent_dice_selection)
	for i in range(skill_buttons.size()):
		skill_buttons[i].disabled = button_disabled[i]
	
	uses_left = YourFighter.stats.mental

func deactivate(br : BattleRefs):
	br.your_dice_visual.dice_selected.disconnect(your_dice_selection)
	br.opponents_dice_visual.dice_selected.disconnect(opponent_dice_selection)
	for button in skill_buttons:
		button.disabled = true

func skill_selected(id : int):
	selected_skill = YourFighter.stats.skills[id]
	
	selection_pop_up.show()
	
	update_reminder()
	
	match (selected_skill.target_type):
		Skill.TargetType.NONE:
			pass
		Skill.TargetType.FINITE_DICE:
			selection_pop_up_confirm.disabled = selected_dice.size() < selected_skill.target_amount
			pass
		Skill.TargetType.ALL_DICE:
			pass

func apply_skill():
	uses_left -= 1
	if uses_left == 0:
		deactivate(battle_refs)
	var skill_action : SkillAction = selected_skill.skill_action.new()
	skill_action.do_action(battle_refs, selected_dice)
	
	battle_refs.your_dice_visual.update_dice_container(battle_refs.you.available_dice)
	battle_refs.opponents_dice_visual.update_dice_container(battle_refs.opponent.available_dice)
	
	selection_pop_up.hide()
	selected_skill = null
	selected_dice.clear()

func update_reminder():
	if selected_skill == null : return
	
	var target : String = ""
	match(selected_skill.target_affiliation):
		Skill.TargetAffiliation.SELF:
			target = "your"
		Skill.TargetAffiliation.OPPONENT:
			target = "the opponents"
	
	match(selected_skill.target_type):
		Skill.TargetType.NONE:
			selection_pop_up_label.text = "Confirm to use skill"
		Skill.TargetType.FINITE_DICE:
			var selected_count = (selected_skill.target_amount - selected_dice.size())
			if selected_count > 0:
				selection_pop_up_label.text = "Select %s more of %s dice to use skill" % [selected_count, target]
			else:
				selection_pop_up_label.text = "Confirm to use skill"
		Skill.TargetType.ALL_DICE:
			selection_pop_up_label.text = "Confirm to use skill"

func your_dice_selection(id : int):
	handle_dice_selection(id, battle_refs.you.available_dice, Skill.TargetAffiliation.SELF)

func opponent_dice_selection(id : int):
	handle_dice_selection(id, battle_refs.you.available_dice, Skill.TargetAffiliation.SELF)

func handle_dice_selection(id : int, target_dice : Array[dice], target_affiliation : Skill.TargetAffiliation):
	if selected_skill == null : return
	if selected_skill.target_affiliation != target_affiliation : return
	
	selection_pop_up_confirm.disabled = selected_dice.size() < selected_skill.target_amount
	
	var die = target_dice[id]
	
	if selected_dice.has(die):
		# Remove
		selected_dice.pop_at(selected_dice.find(die))
	else:
		# Add
		if selected_dice.size() >= selected_skill.target_amount : return
		selected_dice.append(die)
	
	selection_pop_up_confirm.disabled = selected_dice.size() < selected_skill.target_amount
	update_reminder()
