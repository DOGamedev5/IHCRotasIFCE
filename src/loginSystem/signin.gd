extends ColorRect

@onready var matricula := $login/PanelContainer/MarginContainer/VBoxContainer/matricula
@onready var senha := $login/PanelContainer/MarginContainer/VBoxContainer/S/senha
@onready var confirmSenha := $login/PanelContainer/MarginContainer/VBoxContainer/cs/senhaConfirm
@onready var criarConta := $login/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/criar
@onready var erro := $login/PanelContainer/MarginContainer/VBoxContainer/erro

signal loged(userId : int)
signal logCancel()
signal loginInstead()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func reset():
	matricula.text = ""
	senha.text = ""
	confirmSenha.text = ""
	erro.text = ""

func _on_signininstead_pressed() -> void:
	loginInstead.emit()

func _on_cancela_pressed() -> void:
	logCancel.emit()

func _on_criar_pressed() -> void:
	var matr : String = matricula.text
	var sen : String = senha.text
	var senConf : String = confirmSenha.text
	
	if matr.is_empty():
		erro.text = "Por favor, insira a matricula"
	elif UserDataBase.existAccount(matr):
		erro.text = "Essa conta ja existe!"
	elif sen.is_empty():
		erro.text = "Por favor, insira uma senha"
	elif senConf.is_empty():
		erro.text = "Por favor, confirma a sua senha"
	elif sen != senConf:
		erro.text = "As duas senhas estão diferentes!"
	else:
		var accountId = UserDataBase.addUser(matr, sen)
		loged.emit(accountId)

func _on_show_sen_button_down() -> void:
	senha.secret = false

func _on_show_sen_button_up() -> void:
	senha.secret = true

func _on_show_conf_button_down() -> void:
	confirmSenha.secret = false

func _on_show_conf_button_up() -> void:
	confirmSenha.secret = true

func themeUpdated(value : bool):
	var panel : PanelContainer = $login/PanelContainer
	if value:
		panel.get_theme_stylebox("panel").bg_color = Color(0.04, 0.26, 0.16)
	else:
		panel.get_theme_stylebox("panel").bg_color = Color(0.25, 0.43, 0.35)
