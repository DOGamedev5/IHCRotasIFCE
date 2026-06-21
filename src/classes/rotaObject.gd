class_name RotaObject extends Resource


class assentoInfo:
	var userID := -1
	var locked := false
	
	func _init(uID : int, lock := false):
		userID = uID
		locked = lock
	
	func reserve(user : int):
		if not locked:
			userID = user
			locked = true
	

enum ACENTO_STATUS {
	VAZIO,
	OCUPADO_OUTRO,
	RESERVADO
} 
#   Um Enum é basicamento um index de numero,
#   No nosso caso o VAZIO é 0, OCUPADO_OUTRO é 1 e RESERVADO é 2
#   Isso facilita a leitura do codigo para não temos que adivinhar o que um numero
# magico significa no contexto.
#   Funciona basicamente como um valor INT

@export var nome := "A"
@export var horario := "6:30"
@export var acentos : Array = [] # mesma coisa que Array[int] porém deixa claro o contexto dos valores
@export var totalAcentos := 30


func _init(Nome : String, Horario : String, tamanho : int, setupOcupado : Array[int]) -> void:
	nome = Nome
	horario = Horario
	totalAcentos = tamanho
	for i in range(totalAcentos):
		acentos.append(assentoInfo.new(-1))
	#acentos.resize(totalAcentos)
	#acentos.fill(assentoInfo.new(-1))
	acentosOcupadosSetup(setupOcupado)

func reservarAcento(id : int):
	
	if not acentos[id].locked:
		acentos[id].locked = true
		acentos[id].userID = UserDataBase.currentLoged
		
		for i in range(acentos.size()):
			if acentos[i].locked and i != id and acentos[i].userID == UserDataBase.currentLoged:
				acentos[i].locked = false
				acentos[i].userID = -1
			

func acentosOcupadosSetup(listID : Array[int]):
	for i in listID:
		acentos[i].locked = true

func resetAcentos():
	pass
