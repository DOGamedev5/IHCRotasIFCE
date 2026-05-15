extends Button

@export var id : int

signal selected(ID : int, rota : Button)

func init(info : RotaObject, Id : int):
	text = "Onibus " + info.nome + "-> " + info.horario
	id = Id

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.emit(id, self)
