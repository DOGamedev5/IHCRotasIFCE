class_name AcentoButton extends Button

signal selected(id : int)

func _ready() -> void:
	if ProjectSettings.get("global/isMobile"):
		add_theme_font_size_override("font_size", 62)
		custom_minimum_size = Vector2(48*3, 48*3)

func setup(id : int, occupied : bool, reserved : bool):
	text = str(id)
	button_pressed = reserved
	disabled = occupied
	
func _on_toggled(toggled_on: bool) -> void:
	if toggled_on: selected.emit(int(text))
