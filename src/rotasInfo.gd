extends HBoxContainer

@onready var rotas := [
	RotaObject.new("A", "6:30", 23, [0, 1, 20, 12, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "6:30", 21, [0, 1, 20, 16, 3, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "11:10", 23, [0, 1, 19, 20, 10, 9, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "11:10", 21, [0, 1, 20, 15, 3, 12, 13, 14, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "12:30", 23, [0, 1, 20, 12, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "12:30", 21, [18, 1, 20, 16, 3, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "17:10", 23, [0, 1, 19, 20, 10, 9, 4, 22, 2, 3, 19]),
	RotaObject.new("B", "17:10", 21, [0, 1, 20, 15, 3, 12, 13, 14, 3, 20, 18, 5, 4]),
	RotaObject.new("A", "17:30", 23, [0, 1, 20, 12, 4, 3, 22, 2, 3]),
	RotaObject.new("B", "17:30", 21, [18, 1, 20, 16, 3, 3, 20, 2, 5, 4]),
	RotaObject.new("A", "22:10", 23, [0, 1, 19, 20, 10, 9, 4, 22, 2, 3, 19]),
	RotaObject.new("B", "22:10", 21, [0, 1, 20, 15, 3, 12, 13, 14, 3, 20, 18, 5, 4])
]
@onready var rotaSelectScene := preload("res://src/onibusLister/rotaButton/rotaButton.tscn")

@onready var buttonListNode := $margin/list
@onready var buttonListReference := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in rotas.size():
		var button := rotaSelectScene.instantiate()
		button.init(rotas[i], i)
		buttonListNode.add_child(button)
		#buttonListReference.append(button)
		button.connect("selected", rotaSelected)

func rotaSelected(id : int, button):
	for btn in buttonListNode.get_children():
		if btn != button:
			btn.button_pressed = false
	
	
	
