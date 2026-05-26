extends BoxContainer

@onready var rotas := [
	RotaObject.new("A", "6:30", 24, [0, 1, 20, 12, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "6:30", 22, [0, 1, 20, 16, 3, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "11:10", 24, [0, 1, 19, 20, 10, 9, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "11:10", 22, [0, 1, 20, 15, 3, 12, 13, 14, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "12:30", 24, [0, 1, 20, 12, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "12:30", 22, [18, 1, 20, 16, 3, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "17:10", 24, [0, 1, 19, 20, 10, 9, 4, 22, 2, 3, 19]),
	RotaObject.new("B", "17:10", 22, [0, 1, 20, 15, 3, 12, 13, 14, 3, 20, 18, 5, 4]),
	RotaObject.new("A", "17:30", 24, [0, 1, 20, 12, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "17:30", 22, [18, 1, 20, 16, 3, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "22:10", 24, [0, 1, 19, 20, 10, 9, 4, 22, 2, 3, 19]),
	RotaObject.new("B", "22:10", 22, [0, 1, 20, 15, 3, 12, 13, 14, 3, 20, 18, 5, 4])
]
@onready var rotaSelectScene := preload("res://src/classes/rotaButton/rotaButton.tscn")

@export var buttonListNode : Control
@onready var buttonListReference := []

@export var reservarAcentos : Control
@export var scrollThing : Control

@onready var rotasOnibus := {
	"A" : [
		"Nova Acopiara",
		"Centro de Nutrição de Acopiara",
		"Posto desativado",
		"Predio do Padre",
		"Posto Acopiara",
		"Posto Ipiranga",
		"Nossa senhora Aparecida",
		"IFCE - destino Final"
	],
	"B" : [
		"Vila Esperança",
		"Praça",
		"Centro de Acopiara",
		"Liceu",
		"Rodoviaria",
		"Posto Ipiranga",
		"Nossa senhora Aparecida",
		"IFCE - destino Final"
	]
}

@export var rotaLabel : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in rotas.size():
		var button := rotaSelectScene.instantiate()
		button.init(rotas[i], i)
		buttonListNode.add_child(button)
		#buttonListReference.append(button)
		button.connect("selected", rotaSelected)
	
	reservarAcentos.updateInfo.connect(updateInfo)
	if not ProjectSettings.get("global/isMobile"): buttonListNode.get_children()[0].button_pressed = true

func rotaSelected(id : int, button : Button):
	for btn : Button in buttonListNode.get_children():
		if btn != button or ProjectSettings.get("global/isMobile"):
			btn.button_pressed = false
	
	reservarAcentos.setup(rotas[button.id], button.id)
	
	if rotasOnibus.has(rotas[button.id].nome):
		
		var text := ""
		for r in rotasOnibus[rotas[button.id].nome]:
			text += "- " + r + "\n"
		
		rotaLabel.text = text
	
	changeMobileMode(false)

func changeMobileMode(rotaList : bool):
	if ProjectSettings.get("global/isMobile"):
		$margin.visible = rotaList
		if scrollThing: scrollThing.visible = not rotaList
		$voltar.visible = not rotaList
		#$rotaInfo.visible = not rotaList
		#$acentos.visible = not rotaList

func _on_voltar_pressed() -> void:
	changeMobileMode(true)

func updateInfo(data, id):
	rotas[id].reservarAcento(data)
