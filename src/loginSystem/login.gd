extends ColorRect

@onready var matricula := $login/PanelContainer/MarginContainer/VBoxContainer/matricula
@onready var senha := $login/PanelContainer/MarginContainer/VBoxContainer/s/senha
@onready var confirm := $login/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/entrar
@onready var erro := $login/PanelContainer/MarginContainer/VBoxContainer/erro

signal loged(userId : int)
signal logCancel()
signal signInstead()

func _ready() -> void:
	reset()

func reset():
	matricula.text = ""
	senha.text = ""
	erro.text = ""
	confirm.disabled = true

func _process(_delta: float) -> void:
	var matr : String = matricula.text
	var sen : String = senha.text
	
	confirm.disabled = matr.is_empty() or sen.is_empty()

func _on_cancela_pressed() -> void:
	logCancel.emit()

func _on_entrar_pressed() -> void:
	if not UserDataBase.existAccount(matricula.text):
		erro.text = "Conta não existe! talvez você queira criar uma?"
	else:
		var accountId : int = UserDataBase.validateAccount(matricula.text, senha.text)
		if accountId == -1:
			erro.text = "Senha incorreta!"
		else:
			loged.emit(accountId)

func _on_signininstead_pressed() -> void: signInstead.emit()

func _on_show_sen_button_down() -> void: senha.secret = false
func _on_show_sen_button_up() -> void: senha.secret = true
