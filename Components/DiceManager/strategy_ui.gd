extends Container

@export var ui_dice : PackedScene

var ui_dice_instances : Array[UIDice]

func _ready() -> void:
	FighterStats.strategy_updated.connect(update_strategy_container)
	update_strategy_container(FighterStats.strategy)

func update_strategy_container(new_strategy : Array[dice.DiceType]):
	# Create right amount of ui dices
	var difference = new_strategy.size() - ui_dice_instances.size()
	if difference > 0:
		# create difference
		for i in range(difference):
			var new_ui_dice : UIDice = ui_dice.instantiate()
			add_child(new_ui_dice)
			ui_dice_instances.append(new_ui_dice)
	elif difference < 0:
		# delete extras
		for i in range(abs(difference)):
			var dice_instance = ui_dice_instances.pop_back()
			dice_instance.queue_free()
	
	# Set the ui dices
	for i in range(new_strategy.size()):
		var target_ui_dice = ui_dice_instances[i]
		var type = new_strategy[i]
		
		target_ui_dice.set_dice_visual(type,"?")
