extends Button

@export var id : int

signal selected(ID : int, rota : Button)

func init(info : RotaObject, Id : int):
	text = "Onibus " + info.nome + "-> " + info.horario
	id = Id

func _ready():
	if ProjectSettings.get("global/isMobile"):
		add_theme_font_size_override("font_size", 128)


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.emit(id, self)
