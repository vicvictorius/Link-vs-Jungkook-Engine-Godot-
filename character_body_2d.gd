extends CharacterBody2D

const SPEED = 300.0  # Velocidade de movimento
var hp = 60

@onready var animated_sprite = $AnimatedSprite2D 
@export var hearts_container: HBoxContainer  # Referência ao container dos corações
@onready var death_scene: String = "res://game_over.tscn"

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

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

	death()
	# Aplica o movimento
	move_and_slide()

func death():
	if hp <= 0:
		get_tree().change_scene_to_file(death_scene)
		print("personagem destruido!")

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

func damage(dano):
	hp -= dano
	print("Dano recebido:", dano, " | HP restante:", hp)  # Debug
	# Pisca vermelho ao tomar dano
	flash_red()
	update_hearts()

func update_hearts():
	if not hearts_container:
		return
	var heart_value = 15  # Cada coração vale 15 HP
	var current_hearts: int
	if hp <= 0:
		current_hearts = 0
	else:
		current_hearts = ceil(float(hp) / heart_value)
		current_hearts = min(current_hearts, 4)  # Máximo de 4 corações
	
	# Atualiza a visibilidade de cada coração
	for i in range(hearts_container.get_child_count()):
		var heart = hearts_container.get_child(i)
		heart.visible = (i < current_hearts)

func flash_red():
	animated_sprite.modulate = Color(1, 0.3, 0.3)  # Fica avermelhado
	await get_tree().create_timer(0.2).timeout  # Espera 0.2 segundos
	animated_sprite.modulate = Color(1, 1, 1)  # Volta ao normal

func _on_hitboc_body_entered(body: Node2D) -> void:
	print("Colisão detectada com:", body.name)  # Debug para verificar colisões
	if body.name == "link":  # Verifica se o nome do corpo é "jungcook"
		print("COLIDIDO COM O jogador")
		damage(10)
		print(hp)

func _on_hitbox_body_entered(body: Node2D) -> void:
	print("Colisão detectada com:", body.name)  # Debug para verificar colisões
	if body.is_in_group("pimbadores"):
		print("pimbado")
		damage(10)
		print(hp)


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Colisão detectada com:", area.name)  # Debug para verificar colisões
	if area.is_in_group("pimbadores"):
		print("pimbado")
		damage(10)
		print(hp)
