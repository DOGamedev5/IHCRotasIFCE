extends MarginContainer
@onready var references : Array
@onready var btnInstance := preload("res://src/reservasVisualize/acentoButton/acentoButton.tscn")

@onready var listLeft := $content/separator/left
@onready var listRight := $content/separator/right
@onready var textName := $content/Label

@onready var reservBtn := $content/buttons/reserva

@onready var currentAcento := -1
@onready var hasChanged := false
@onready var currentID := 0

signal updateInfo(data, id : int)
signal requestLogin()

func _ready() -> void:
	if ProjectSettings.get("global/isMobile"):
		textName.add_theme_font_size_override("font_size", 48+18)
		reservBtn.add_theme_font_size_override("font_size", 36+18+9)
		reservBtn.text = " Reservar Assento "

func setup(info : RotaObject, id : int):
	textName.text = "ÔNIBUS {0} > {1}".format([info.nome, info.horario])
	currentID = id
	_clearLists()
	_create_buttons(info)

func _process(_delta: float) -> void:
	#var canReserve : bool = get_tree().current_scene.isAluno()
	#reservBtn.disabled = not canReserve or not hasChanged
	reservBtn.disabled = not hasChanged

func _create_buttons(info : RotaObject):
	var listSize : float = float(info.totalAcentos) / 2
	var lSize : int = ceil(listSize)
	var rSize : int = floor(listSize)
	for i in range(lSize): # começa no 0 e para no lSize - 1
		var btn : AcentoButton = btnInstance.instantiate()
		btn.setup(i + 1, info.acentos[i] == 1, info.acentos[i] == 2)
		if info.acentos[i] == 2: currentAcento = i
		btn.selected.connect(acentoEscolhido)
		
		listLeft.add_child(btn)
	
	for i in range(lSize, lSize+rSize): # começa no lSize e para no lSize+rSize - 1
		var btn : AcentoButton = btnInstance.instantiate()
		btn.setup(i + 1, info.acentos[i] == 1, info.acentos[i] == 2)
		if info.acentos[i] == 2: currentAcento = i
		btn.selected.connect(acentoEscolhido)
		
		listRight.add_child(btn)
	
func _clearLists():
	for btn in listLeft.get_children(): btn.queue_free()
	for btn in listRight.get_children(): btn.queue_free()
	hasChanged = false

func _on_reserva_pressed() -> void:
	var canReserve : bool = get_tree().current_scene.isAluno()
	
	if canReserve:
		hasChanged = false
		updateInfo.emit(currentAcento, currentID)
	else:
		requestLogin.emit()
	
func acentoEscolhido(id: int):
	for btn : Button in listLeft.get_children():
		var ID = int(btn.text)
		if ID != id && btn.button_pressed: btn.button_pressed = false
			
	for btn : Button in listRight.get_children(): 
		var ID = int(btn.text)
		if ID != id && btn.button_pressed: btn.button_pressed = false
	
	currentAcento = id-1
	hasChanged = true

func _on_login() -> void:
	if hasChanged: _on_reserva_pressed()
