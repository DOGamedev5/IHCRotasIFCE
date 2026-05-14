extends Control

@onready var currentTab := 1
@onready var tabsButtons := [
	$MarginContainer/VBoxContainer/options/HBoxContainer/reserva,
	$MarginContainer/VBoxContainer/options/HBoxContainer/horarios,
	$MarginContainer/VBoxContainer/options/HBoxContainer/avisos
]
@onready var tabs := [
	$"MarginContainer/VBoxContainer/visualize/Reservar assentos",
	$MarginContainer/VBoxContainer/visualize/horarioList,
	$MarginContainer/VBoxContainer/visualize/avisos
]
@onready var loginTab := $login
@onready var matriculaText := $login/login/PanelContainer/MarginContainer/VBoxContainer/matricula
@onready var senhaText := $login/login/PanelContainer/MarginContainer/VBoxContainer/senha

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func tab_changed(toggled_on: bool, id: int) -> void:
	if toggled_on == true:
		for i in range(tabsButtons.size()):
			tabsButtons[i].button_pressed = i == id
			tabs[i].visible = tabsButtons[i].button_pressed
	

func _on_login_pressed() -> void:
	matriculaText.text = ""
	senhaText.text = ""
	loginTab.visible = true

func _on_cancela_pressed() -> void:
	loginTab.visible = false

func _on_entrar_pressed() -> void:
	loginTab.visible = false
	$MarginContainer/VBoxContainer/options/HBoxContainer/login.text = "mudar de conta"
