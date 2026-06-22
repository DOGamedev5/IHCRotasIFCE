extends Node

class User:
	var matricula := ""
	var senha := ""
	
	func _init(Matricula : String, Senha : String):
		matricula = Matricula
		senha = Senha
	
	func iam(Matricula):
		return matricula == Matricula
	
	func isValid(Matricula : String, Senha : String):
		return matricula == Matricula and senha == Senha

@onready var currentLoged = -2

@onready var users : Array[User] = [
	
]

func addUser(matricula : String, senha : String):
	users.append(User.new(matricula, senha))
	return users.size() - 1

func existAccount(matricula : String):
	for i in range(users.size()):
		if users[i].iam(matricula):
			return true
	
	return false

func validateAccount(matricula : String, senha : String):
	for i in range(users.size()):
		if users[i].isValid(matricula, senha):
			return i
	
	return -1

func loginID(id : int): currentLoged = id
	
