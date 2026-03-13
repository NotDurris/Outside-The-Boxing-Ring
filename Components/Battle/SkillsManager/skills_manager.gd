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
@export var selection_pop_up_description : Label
@export var selection_pop_up_close : Button
@export var selection_pop_up_confirm : Button

var selected_dice : Array[dice]
var selected_skill : Skill

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
	selection_pop_up_close.pressed.connect(close_selection_pop_up)
	
	for i in range(skill_buttons.size()):
		skill_buttons[i].pressed.connect(func() : skill_selected(i))

func close_selection_pop_up():
	selection_pop_up.hide()
	selected_dice.clear()
	selected_skill = null

func skill_selected(id : int):
	selection_pop_up.show()
	selected_skill = YourFighter.stats.skills[id]
	
	update_reminder_text()
	update_description_text()
	
	match (selected_skill.target_type):
		Skill.TargetType.NONE:
			pass
		Skill.TargetType.FINITE_DICE:
			selection_pop_up_confirm.disabled = selected_dice.size() < selected_skill.target_amount
			pass
		Skill.TargetType.ALL_DICE:
			pass

func update_reminder_text():
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

func update_description_text():
	selection_pop_up_description.text = selected_skill.name + "\n" + selected_skill.description

func set_usage_dots():
	for dot in skill_dots:
		dot.queue_free()
	skill_dots.clear()
	
	for i in range(YourFighter.stats.mental):
		var new_dot : Dot = DOT.instantiate()
		skill_dots.append(new_dot)
		dots_container.add_child(new_dot)

func initiate_btns(br : BattleRefs):
	for connection in selection_pop_up_confirm.pressed.get_connections():
		selection_pop_up_confirm.pressed.disconnect(connection)
	
	selection_pop_up_confirm.pressed.connect(func() : apply_skill(br))
	br.your_dice_visual.dice_selected.connect(func(value) : your_dice_selection(value, br))
	br.opponents_dice_visual.dice_selected.connect(func(value) : opponent_dice_selection(value, br))

func initiate_skills(br : BattleRefs):
	initiate_btns(br)
	
	selection_pop_up.hide()
	
	set_usage_dots()
	
	for i in range(skill_buttons.size()):
		var target_button : Button = skill_buttons[i]
		if i < YourFighter.stats.skills.size() and YourFighter.stats.skills.size() != 0:
			button_disabled[i] = false
			target_button.disabled = button_disabled[i]
			target_button.text = YourFighter.stats.skills[i].name
		else:
			button_disabled[i] = true
			target_button.disabled = button_disabled[i]

func activate(_br : BattleRefs):
	for i in range(skill_buttons.size()):
		skill_buttons[i].disabled = button_disabled[i]
	
	uses_left = YourFighter.stats.mental

func deactivate(_br : BattleRefs):
	for button in skill_buttons:
		button.disabled = true

func apply_skill(br : BattleRefs):
	uses_left -= 1
	if uses_left == 0:
		deactivate(br)
	var skill_action : SkillAction = selected_skill.skill_action.new()
	skill_action.do_action(br, selected_dice)
	
	br.your_dice_visual.update_dice_container(br.you.available_dice)
	br.opponents_dice_visual.update_dice_container(br.opponent.available_dice)
	
	selection_pop_up.hide()
	selected_skill = null
	selected_dice.clear()

func your_dice_selection(id : int, br : BattleRefs):
	handle_dice_selection(id, br.you.available_dice, Skill.TargetAffiliation.SELF)

func opponent_dice_selection(id : int, br : BattleRefs):
	handle_dice_selection(id, br.you.available_dice, Skill.TargetAffiliation.OPPONENT)

func handle_dice_selection(id : int, target_dice : Array[dice], target_affiliation : Skill.TargetAffiliation):
	if selected_skill == null : return
	if selected_skill.target_affiliation != target_affiliation or selected_skill.target_affiliation == Skill.TargetAffiliation.BOTH : return
	
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
	update_reminder_text()
