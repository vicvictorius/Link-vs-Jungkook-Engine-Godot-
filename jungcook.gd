extends CharacterBody2D

@export var speed: float = 100.0
@export var stop_distance: float = 230
@export var retreat_distance: float = 200
@export var bullet_scene: PackedScene  # Cena do projétil

var player: Node2D = null

@onready var shoot_timer = $Timer  # Timer para controlar os tiros

func _ready():
	player = get_node_or_null("../character/link")  # Ajuste o caminho conforme necessário
	if player:
		print("Jogador encontrado!")  # Debug
		$Timer.start()  # Inicia o Timer
	else:
		print("Jogador não encontrado!")  # Debug

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		var distance = global_position.distance_to(player.global_position)
		
		if distance > stop_distance:
			velocity = direction * speed
		elif distance < retreat_distance:
			velocity = -direction * speed
		else:
			velocity = Vector2.ZERO

		move_and_slide()  # Corrigido aqui, sem o segundo argumento

func _on_timer_timeout():
	print("Timer disparado!")  # Debug
	if player:
		shoot_at_player()

func shoot_at_player():
	print("Tentando atirar...")  # Debug
	if bullet_scene:
		print("Cena do projétil carregada!")  # Debug
		var bullet = bullet_scene.instantiate()  # Instancia o projétil
		bullet.direction = (player.global_position - global_position).normalized()  # Define a direção do projétil
		bullet.global_position = global_position  # Define a posição inicial do projétil
		get_parent().add_child(bullet)  # Adiciona o projétil à cena
		print("Projétil instanciado e disparado!")  # Debug
	else:
		print("Erro: Cena do projétil não carregada!")  # Debug
