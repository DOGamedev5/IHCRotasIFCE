class_name AcentoButton extends Button

func setup(id : int, occupied : bool, reserved : bool):
	text = str(id)
	button_pressed = reserved
	disabled = occupied
