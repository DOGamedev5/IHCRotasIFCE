extends Control

@onready var desktop := preload("res://src/desktopMain/main.tscn")
@onready var mobile := preload("res://src/mobileMain/main.tscn")

@onready var main : Node

func _ready() -> void:
	print(ProjectSettings.get("global/isMobile"))
	if OS.has_feature("mobile"):
		main = mobile.instantiate()
		ProjectSettings.set("global/isMobile", true)
	else:
		main = desktop.instantiate()
		ProjectSettings.set("global/isMobile", false)
		
	print(ProjectSettings.get("global/isMobile"))
	
	add_child(main)
