extends MarginContainer
@onready var references : Array
@onready var btnInstance := preload("res://src/reservasVisualize/acentoButton/acentoButton.tscn")

@onready var listLeft := $content/separator/left
@onready var listRight := $content/separator/right
@onready var textName := $content/Label

func _ready() -> void:
	if ProjectSettings.get("global/isMobile"):
		textName.add_theme_font_size_override("font_size", 48)
		$content/HBoxContainer2/reserva.add_theme_font_size_override("font_size", 36)
		$content/HBoxContainer2/reserva2.add_theme_font_size_override("font_size", 36)

func setup(info : RotaObject):
	textName.text = "ÔNIBUS {0} -> {1}".format([info.nome, info.horario])
	_clearLists()
	_create_buttons(info)

func _create_buttons(info : RotaObject):
	var listSize : float = float(info.totalAcentos) / 2
	var lSize : int = ceil(listSize)
	var rSize : int = floor(listSize)
	for i in range(lSize): # começa no 0 e para no lSize - 1
		var btn : AcentoButton = btnInstance.instantiate()
		btn.setup(i + 1, info.acentos[i] == 1, info.acentos[i] == 2)
		
		listLeft.add_child(btn)
	
	for i in range(lSize, lSize+rSize): # começa no lSize e para no lSize+rSize - 1
		var btn : AcentoButton = btnInstance.instantiate()
		btn.setup(i + 1, info.acentos[i] == 1, info.acentos[i] == 2)
		listRight.add_child(btn)
	
func _clearLists():
	for btn in listLeft.get_children(): btn.queue_free()
	for btn in listRight.get_children(): btn.queue_free()
