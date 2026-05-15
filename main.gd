extends Control

@onready var desktop := preload("res://src/desktopMain/main.tscn")
@onready var mobile := preload("res://src/mobileMain/main.tscn")

@onready var main : Node

func _ready() -> void:
	
	if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
		main = mobile.instantiate()
		ProjectSettings.set("global/isMobile", true)
	else:
		main = desktop.instantiate()
		ProjectSettings.set("global/isMobile", false)
		
	
	
	add_child(main)
