extends Node2D  # Ou Sprite2D

# Posições relativas ao personagem
var default_offset = Vector2(-30, 0)  # Posição ao lado do personagem
var defense_offset = Vector2(0, 50)   # Posição na frente do personagem

# Rotação padrão e de defesa
var default_rotation: float = 0.0  # Sem rotação
var defense_rotation: float = -90.0  # Rotação de -90 graus

# Velocidade de suavização
var move_speed = 10.0  # Velocidade de movimento
var rotation_speed = 5.0  # Velocidade de rotação

# Referência ao personagem (arraste o nó do personagem para esta variável no editor)
@export var personagem: CharacterBody2D

func _physics_process(delta):
	if not personagem:
		return  # Se não houver personagem, não faz nada

	# Verifica se o input está sendo detectado
	if Input.is_action_pressed("mouse_right"):
		print("Botão direito do mouse pressionado!")  # Debug
		move_and_rotate(defense_offset, defense_rotation, delta)
	else:
		print("Botão direito do mouse NÃO pressionado!")  # Debug
		move_and_rotate(default_offset, default_rotation, delta)

func move_and_rotate(target_offset: Vector2, target_rotation: float, delta: float):
	# Calcula a posição alvo global
	var target_position = personagem.position + target_offset

	# Suaviza o movimento
	global_position = global_position.move_toward(target_position, move_speed * delta)

	# Suaviza a rotação
	var rotation_difference = deg_to_rad(target_rotation) - rotation
	rotation += rotation_difference * rotation_speed * delta
