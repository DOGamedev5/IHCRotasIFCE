extends Button

@export var id : int

signal selected(ID : int, rota : Button)

func init(info : RotaObject, Id : int):
	text = "Onibus " + info.nome + "-> " + info.horario
	id = Id

func _ready():
	if ProjectSettings.get("global/isMobile"):
		add_theme_font_size_override("font_size", 64)

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.emit(id, self)

func themeChanged(value : bool):
	if value:
		add_theme_color_override("font_pressed_color", Color(0.16, 0.4, 0.63))
	else:
		add_theme_color_override("font_pressed_color", Color(0.06, 0.09, 0.23))
