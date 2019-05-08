extends Panel


func _gui_input(event):
	"""
	Detects when dialogue box is clicked.
	"""
	if event is InputEventMouseButton:
		if(event.pressed and event.button_index == BUTTON_LEFT):
			if Dialogue.mode == 'continuous':
				Dialogue.next()
