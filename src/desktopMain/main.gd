extends Control

@onready var currentTab := 1
@onready var tabsButtons := [
	$MarginContainer/VBoxContainer/options/HBoxContainer/rotas,
	$MarginContainer/VBoxContainer/options/HBoxContainer/avisos
]
@onready var tabs := [
	$"MarginContainer/VBoxContainer/visualize/rotasInfo",
	$MarginContainer/VBoxContainer/visualize/avisos
]
@onready var loginTab := $login
@onready var matriculaText := $login/login/PanelContainer/MarginContainer/VBoxContainer/matricula
@onready var senhaText := $login/login/PanelContainer/MarginContainer/VBoxContainer/senha

@onready var isLoginRequested := false

signal onLogin

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
	isLoginRequested = false

func _on_entrar_pressed() -> void:
	loginTab.visible = false
	$MarginContainer/VBoxContainer/options/HBoxContainer/login.text = "mudar de conta"
	get_tree().current_scene.setLoginState(1)
	if isLoginRequested:
		onLogin.emit()
		isLoginRequested = false

func _on_acentos_request_login() -> void:
	_on_login_pressed()
	isLoginRequested = true
