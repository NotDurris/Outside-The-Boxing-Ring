class_name DiceContainer
extends Control

signal dice_selected(id : int)

const UI_DICE = preload("uid://b16piwmo3c5nf")

var ui_dice_instances : Array[UIDice]

var target_fighter : Fighter

func update_target_fighter(new_fighter : Fighter):
	if target_fighter != null:
		target_fighter.dice_updated.disconnect(update_dice_container)
	
	target_fighter = new_fighter
	
	target_fighter.dice_updated.connect(update_dice_container)
	update_dice_container(target_fighter.available_dice)

func update_dice_container(new_dice_array : Array[dice]):
	# Create right amount of ui dices
	resize_dice_array(new_dice_array.size())
	
	for i in range(new_dice_array.size()):
		var target_ui_dice = ui_dice_instances[i]
		
		target_ui_dice.target_dice = new_dice_array[i]

func resize_dice_array(target_size : int):
	var difference = target_size - ui_dice_instances.size()
	
	if difference == 0 : return
	
	if difference > 0:
		# create difference
		for i in range(difference):
			var new_ui_dice : UIDice = UI_DICE.instantiate()
			new_ui_dice.pressed.connect(func() : dice_selected.emit(i))
			new_ui_dice.name = new_ui_dice.name + name
			add_child(new_ui_dice)
			ui_dice_instances.append(new_ui_dice)
	elif difference < 0:
		# delete extras
		for i in range(abs(difference)):
			var dice_instance = ui_dice_instances.pop_back()
			dice_instance.queue_free()
	
	# Set dice sizes
	var x_size : float = max(453.0, size.x)
	var dice_size : float = min(x_size / (ui_dice_instances.size() + 2), 64)
	for die in ui_dice_instances:
		die.target_scale = dice_size

func scale_strategy_dice(target_scale : Vector2):
	var tweener : Tween = get_tree().create_tween()
	tweener.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	for die in ui_dice_instances:
		tweener.tween_property(die, "scale", target_scale, 0.1)
	
	await tweener.finished
