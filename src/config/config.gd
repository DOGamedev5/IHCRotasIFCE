extends ColorRect

@onready var salvar := $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/salver

@onready var themeButton := $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/hbox/vbox/tema/Button

signal themeChanged(value : bool)
var darkTheme := true
var darkThemeChange := false

func _process(_delta):
	salvar.disabled = not (darkThemeChange)

func resetValues():
	themeButton.button_pressed = darkTheme
	darkThemeChange = false

func _on_button_toggled(toggled_on: bool) -> void:
	darkThemeChange = darkTheme != toggled_on
	#themeChanged.emit(toggled_on)

func _on_cancela_pressed() -> void:
	visible = false

func _on_salver_pressed() -> void:
	if darkThemeChange:
		themeChanged.emit(not darkTheme)
		darkTheme = not darkTheme
		darkThemeChange = false
	
	visible = false
		

func themeUpdated(value : bool):
	var panel : PanelContainer = $MarginContainer/PanelContainer
	if value:
		panel.get_theme_stylebox("panel").bg_color = Color(0.04, 0.26, 0.16)
	else:
		panel.get_theme_stylebox("panel").bg_color = Color(0.25, 0.43, 0.35)
	
