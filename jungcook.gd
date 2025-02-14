extends CharacterBody2D

var hp = 1000

var player: Node2D = null

@export var speed: float = 75.0
@export var stop_distance: float = 230
@export var retreat_distance: float = 200
@export var bullet_scene: PackedScene  # Cena do projétil
@export var army_scene: PackedScene  # Cena do exército (defina essa variável na interface do Godot)
@onready var shoot_timer = $Timer  # Timer para controlar os tiros
@onready var army_timer = $Timer2


func _ready():
	player = get_node_or_null("../character/link")  # Ajuste o caminho conforme necessário
	if player:
		print("Jogador encontrado!")  # Debug
		$Timer.start()  # Inicia o Timer
		$Timer2.start()
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
		death()
		move_and_slide()  # Corrigido aqui, sem o segundo argumento

func death():
	if hp <= 0:
		queue_free()
		print("Personagem destruído!")

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

func gang_de_army():
	print("Tentando chamar o exército...")
	if army_scene:
		# Gerar uma posição aleatória dentro de um círculo ao redor do personagem
		var radius = 400.0  # Raio máximo ao redor do personagem
		var angle = randf_range(0, 2 * PI)  # Gerar um ângulo aleatório entre 0 e 2π
		var distance = randf_range(0, radius)  # Gerar uma distância aleatória dentro do raio

		# Calcular a posição baseada no ângulo e na distância
		var offset = Vector2(cos(angle), sin(angle)) * distance
		
		# Instanciar o exército e definir sua posição
		var army = army_scene.instantiate()  # Instancia o exército
		army.global_position = global_position + offset  # Define a posição ao redor do personagem
		
		# Adicionar o exército à cena
		get_parent().add_child(army)  # Adiciona o exército à cena
		print("Army invocada em uma posição aleatória!")  # Debug
	else:
		print("Erro: Cena do exército não carregada!")  # Debug

func damage(dano):
	hp -= dano

func _on_timer_2_timeout() -> void:
	print("Timer2 disparado!")  # Debug
	if player:
		gang_de_army()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "jungcook":  # Verifica se o nome do corpo é "jungcook"
		print("COLIDIDO COM O jungcook")
		damage(10)
		print(hp)
