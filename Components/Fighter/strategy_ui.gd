class_name StrategyUI
extends Container

const UI_DICE = preload("uid://b16piwmo3c5nf")

var ui_dice_instances : Array[UIDice]

func set_type_of_strategy(type_array : Array[dice.DiceType]):
	for i in range(type_array.size()):
		var target_ui_dice = ui_dice_instances[i]
		var type = type_array[i]
		
		target_ui_dice.set_dice_background(type)

func set_text_of_strategy(text_array : Array[String]):
		for i in range(text_array.size()):
			var target_ui_dice = ui_dice_instances[i]
			var text = text_array[i]
			
			target_ui_dice.set_dice_text(text)

func resize_strategy(target_size : int):
	var difference = target_size - ui_dice_instances.size()
	
	if difference == 0 : return
	
	if difference > 0:
		# create difference
		for i in range(difference):
			var new_ui_dice : UIDice = UI_DICE.instantiate()
			add_child(new_ui_dice)
			ui_dice_instances.append(new_ui_dice)
	elif difference < 0:
		# delete extras
		for i in range(abs(difference)):
			var dice_instance = ui_dice_instances.pop_back()
			dice_instance.queue_free()

func update_strategy_container_from_type(new_strategy : Array[dice.DiceType]):
	# Create right amount of ui dices
	resize_strategy(new_strategy.size())
	
	# Set the ui dices
	for i in range(new_strategy.size()):
		var target_ui_dice = ui_dice_instances[i]
		var type = new_strategy[i]
		
		target_ui_dice.set_dice_visual(type,"?")

func update_strategy_from_dice(new_strategy : Array[dice]):
	# Create right amount of ui dices
	resize_strategy(new_strategy.size())
	
	for i in range(new_strategy.size()):
		var target_ui_dice = ui_dice_instances[i]
		var type = new_strategy[i].type
		var text = str(new_strategy[i].value)
		
		target_ui_dice.set_dice_visual(type,text)
