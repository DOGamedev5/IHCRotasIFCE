extends Control

@onready var desktop := preload("res://src/desktopMain/main.tscn")
@onready var mobile := preload("res://src/mobileMain/main.tscn")

func _ready() -> void:
	if OS.has_feature("mobile"):
		add_child(mobile.instantiate())
	else:
		add_child(desktop.instantiate())
