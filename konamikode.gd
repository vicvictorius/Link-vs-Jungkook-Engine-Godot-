extends Node

# Sequência do Konami Code
var konami_code = ["up", "up", "down", "down", "left", "right", "left", "right", "b", "a"]
var input_buffer = []

func _process(delta):
	if Input.is_action_just_pressed("up"):
		print("cima")
		input_buffer.append("up")
		print(input_buffer)
	if Input.is_action_just_pressed("ui_down"):
		print("baixo")
		input_buffer.append("down")
		print(input_buffer)
	if Input.is_action_just_pressed("ui_left"):
		print("esquerda")
		input_buffer.append("left")
		print(input_buffer)
	if Input.is_action_just_pressed("ui_right"):
		print("direita")
		input_buffer.append("right")
		print(input_buffer)
	if Input.is_action_just_pressed("konami_b"):
		print("b")
		input_buffer.append("b")
		print(input_buffer)
	if Input.is_action_just_pressed("konami_a"):
		print("a")
		input_buffer.append("a")
		print(input_buffer)

	# Verifique se o buffer de entradas é igual ao Konami Code
	if input_buffer == konami_code:
		print("Konami Code ativado!")
		input_buffer.clear()  # Limpar o buffer após ativação
