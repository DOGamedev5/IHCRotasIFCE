class_name RotaObject extends Resource


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
@export var acentos : Array[ACENTO_STATUS]= [] # mesma coisa que Array[int] porém deixa claro o contexto dos valores
@export var totalAcentos := 30


func _init(Nome : String, Horario : String, tamanho : int, setupOcupado : Array[int]) -> void:
	nome = Nome
	horario = Horario
	totalAcentos = tamanho
	acentos.resize(totalAcentos)
	acentos.fill(ACENTO_STATUS.VAZIO)
	acentosOcupadosSetup(setupOcupado)

func reservarAcento(id : int):
	
	if acentos[id] == ACENTO_STATUS.VAZIO:
		acentos[id] = ACENTO_STATUS.RESERVADO
		print("AAAA")
		for i in range(acentos.size()):
			if acentos[i] == ACENTO_STATUS.RESERVADO and i != id:
				acentos[i] = ACENTO_STATUS.VAZIO
				print("BBBB")
			

func acentosOcupadosSetup(listID : Array[int]):
	for i in listID: acentos[i] = ACENTO_STATUS.OCUPADO_OUTRO
