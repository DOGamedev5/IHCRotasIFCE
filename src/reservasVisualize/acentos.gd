extends MarginContainer
@onready var references : Array

func setup(info : RotaObject):
	_create_buttons(info)

func _create_buttons(info : RotaObject):
	var size : int = (info.totalAcentos - 1) / 2
	var lSize : int = ceil(size) + 1
	var rSize : int = floor(size) + 1
	
	
