class_name ResultsScreen
extends PanelContainer

@onready var results_label : Label = $VBoxContainer/result_label
@onready var loss_notification : Control = $VBoxContainer/Loss
@onready var close_button : Button = $VBoxContainer/Close

func show_results(br : BattleRefs):
	show()
	var final_result : int = br.you.wins - br.opponent.wins
	
	if final_result > 0:
		# Won
		results_label.text = "VICTORY"
		loss_notification.hide()
	elif final_result < 0:
		# Lost
		results_label.text = "DEFEAT"
		loss_notification.show()
	else:
		# Draw
		results_label.text = "DRAW"
		loss_notification.show()
