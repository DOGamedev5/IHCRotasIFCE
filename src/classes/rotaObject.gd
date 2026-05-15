class_name RotaObject extends Resource

@export var nome := "A"
@export var horario := "6:30"
@export var acentos : Array[int]= []
@export var totalAcentos := 30

enum ACENTO_STATUS {
	VAZIO,
	OCUPADO_OUTRO,
	RESERVADO
} 
#   Um Enum é basicamento um index de numero,
#   No nosso caso o VAZIO é 0, OCUPADO_OUTRO é 1 e RESERVADO é 2
#   Isso facilita a leitura do codigo para não temos que adivinhar o que um numero
# magico significa no contexto.

func init() -> void:
	acentos.resize(totalAcentos)
	acentos.fill(ACENTO_STATUS.VAZIO)

func reservarAcento(id : int):
	if acentos[id] == ACENTO_STATUS.VAZIO:
		acentos[id] = ACENTO_STATUS.RESERVADO

func acentosOcupadosSetup(listID : Array[int]):
	for i in listID: acentos[i] = ACENTO_STATUS.OCUPADO_OUTRO
