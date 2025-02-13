extends CharacterBody2D

const SPEED = 300.0  # Velocidade de movimento

@onready var animated_sprite = $AnimatedSprite2D 
func _physics_process(delta: float) -> void:
	# Inicializa o vetor de movimento
	velocity = Vector2.ZERO

	# Captura a entrada do jogador
	if Input.is_action_pressed("up"):
		velocity.y -= 1  # Move para cima
	if Input.is_action_pressed("down"):
		velocity.y += 1  # Move para baixo
	if Input.is_action_pressed("left"):
		velocity.x -= 1  # Move para a esquerda
	if Input.is_action_pressed("right"):
		velocity.x += 1  # Move para a direita

	# Normaliza o vetor de movimento para evitar movimento mais rápido na diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED

	# Aplica o movimento
	move_and_slide()

	# Faz o personagem olhar para o mouse com um offset de 90 graus
	look_at_mouse()
	
	if get_real_velocity() == Vector2.ZERO:
		if animated_sprite.animation != "default":
			animated_sprite.play("default")
	else:
		if animated_sprite.animation != "link walking":
			animated_sprite.play("link walking")

func look_at_mouse():
	# Obtém a posição do mouse na tela
	var mouse_position = get_global_mouse_position()
	
	# Calcula o ângulo entre a posição do personagem e a posição do mouse
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()
	
	# Aplica a rotação ao personagem com um offset de 90 graus
	rotation = angle + deg_to_rad(-90)
