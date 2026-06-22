class_name AcentoButton extends Button

signal selected(id : int)

@onready var locked := false

func _ready() -> void:
	if ProjectSettings.get("global/isMobile"):
		add_theme_font_size_override("font_size", 62)
		custom_minimum_size = Vector2(48*3, 48*3)

func setup(id : int, occupied : bool, reserved : bool):
	text = str(id)
	button_pressed = reserved
	disabled = occupied and not reserved
	locked = reserved
	
func _on_toggled(toggled_on: bool) -> void:
	if locked:
		toggled_on = true
		button_pressed = true
	if toggled_on: selected.emit(int(text))

func setLocked(value : bool):
	locked = value
	
	if locked:
		modulate = Color(0.6, 0.6, 0.6)
	else:
		modulate = Color.WHITE
		

func themeUpdate(value : bool):
	if value:
		add_theme_color_override("font_color", Color.BLACK)
		add_theme_color_override("font_focus_color", Color.BLACK)
	else:
		add_theme_color_override("font_color", Color.WHITE)
		add_theme_color_override("font_focus_color", Color.WHITE)
		pass
	
