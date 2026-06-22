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
@onready var signinTab := $signin
@onready var configTab := $config

@onready var isLoginRequested := false

signal onLogin

func _ready() -> void:
	_on_config_theme_changed(true)

func tab_changed(toggled_on: bool, id: int) -> void:
	if toggled_on == true:
		for i in range(tabsButtons.size()):
			tabsButtons[i].button_pressed = i == id
			tabs[i].visible = tabsButtons[i].button_pressed
	

func _on_cancela_pressed() -> void:
	loginTab.visible = false
	signinTab.visible = false
	isLoginRequested = false

func _on_entrar_pressed(id : int) -> void:
	UserDataBase.loginID(id)
	loginTab.visible = false
	signinTab.visible = false
	$MarginContainer/VBoxContainer/options/HBoxContainer/login.text = "mudar de conta"
	var scene = get_tree().current_scene

	if scene.getLoginState() == 1:
		tabs[0].refreshSeatsState()
	else:
		get_tree().current_scene.setLoginState(1)
		
	onLogin.emit()
	
	if isLoginRequested:
		isLoginRequested = false
	

func _on_acentos_request_login() -> void:
	_on_login_pressed()
	isLoginRequested = true

func _on_signin_pressed() -> void:
	signinTab.reset()
	signinTab.visible = true
	loginTab.visible = false

func _on_login_pressed() -> void:
	loginTab.reset()
	loginTab.visible = true
	signinTab.visible = false

func _on_config_pressed() -> void:
	configTab.resetValues()
	configTab.visible = true

func _on_config_theme_changed(value: bool) -> void:
	if value:
		$fundo.color = Color(0.04, 0.14, 0.16, 1.00)
	else:
		$fundo.color = Color.WHITE#Color(0.91, 1.00, 0.82, 1.00)
		
	tabs[0].themeChanged(value)
	configTab.themeUpdated(value)
	signinTab.themeUpdated(value)
	loginTab.themeUpdated(value)
