extends CharacterBody2D

var hp = 1000

var player: Node2D = null

@export var speed: float = 75.0
@export var stop_distance: float = 230
@export var retreat_distance: float = 200
@export var bullet_scene: PackedScene  # Cena do projétil
@export var army_scene: PackedScene  # Cena do exército (defina essa variável na interface do Godot)@export var army_scene: PackedScene  # Cena do exército (defina essa variável na interface do Godot)
@export var army_scene2: PackedScene  # Cena do exército (defina essa variável na interface do Godot)
@onready var shoot_timer = $Timer  # Timer para controlar os tiros
@onready var army_timer = $Timer2
@onready var meiotempo = $meiotempo
@onready var army_timer2 = $timerarmy2
@onready var health_bar: ProgressBar = $"../character/Camera2D/Control/jungcookheathbar"  # Ajuste o caminho conforme necessário
var explosion_scene = preload("res://bigexplosion.tscn")  # Ajuste o caminho para a sua cena de explosão
@onready var sprite: Sprite2D = $Sprite2D  # Ajuste o caminho para o Sprite2D
@onready var gg_scene: String = "res://gg.tscn"
const KNOCKBACK_FORCE = 1000.0  # Força do knockback
const KNOCKBACK_DECAY = 0.1  # Redução gradual da velocidade do knockback
var knockback_velocity: Vector2 = Vector2.ZERO  # Velocidade do knockback

func _ready():
	player = get_node_or_null("../character/link")  # Ajuste o caminho conforme necessário
	if player:
		print("Jogador encontrado!")  # Debug
		$Timer.start()  # Inicia o Timer
		$Timer2.start()
	else:
		print("Jogador não encontrado!")  # Debug

	update_health_bar()  # Atualiza a barra de vida no início

func _physics_process(delta):
	if player:
		# Aplica o knockback, se houver
		if knockback_velocity != Vector2.ZERO:
			velocity = knockback_velocity
			move_and_slide()

			# Reduz gradualmente a velocidade do knockback
			knockback_velocity *= KNOCKBACK_DECAY

			# Reseta o knockback quando ele for muito pequeno
			if knockback_velocity.length() < 10:
				knockback_velocity = Vector2.ZERO
		else:
			# Movimentação normal em direção ao jogador
			var direction = (player.global_position - global_position).normalized()
			var distance = global_position.distance_to(player.global_position)
			
			if distance > stop_distance:
				velocity = direction * speed
			elif distance < retreat_distance:
				velocity = -direction * speed
			else:
				velocity = Vector2.ZERO
			move_and_slide()

	death()  # Verifica se o personagem morreu

func death():
	if hp <= 0:
		# Instancia a explosão
		var explosion = explosion_scene.instantiate()
		get_parent().add_child(explosion)  # Adiciona a explosão ao mundo
		explosion.global_position = global_position  # Posiciona a explosão no mesmo lugar do inimigo
		get_tree().change_scene_to_file(gg_scene)
		print("Personagem destruído!")

func _on_timer_timeout():
	if player:
		shoot_at_player()

func shoot_at_player():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()  # Instancia o projétil
		bullet.direction = (player.global_position - global_position).normalized()  # Define a direção do projétil
		bullet.global_position = global_position  # Define a posição inicial do projétil
		get_parent().add_child(bullet)  # Adiciona o projétil à cena
		bullet.name = "Bullet"
	else:
		print("Erro: Cena do projétil não carregada!")  # Debug

func gang_de_army():
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
	else:
		print("Erro: Cena do exército não carregada!")  # Debug

func gang_de_army2():
	if army_scene:
		# Gerar uma posição aleatória dentro de um círculo ao redor do personagem
		var radius = 400.0  # Raio máximo ao redor do personagem
		var angle = randf_range(0, 2 * PI)  # Gerar um ângulo aleatório entre 0 e 2π
		var distance = randf_range(0, radius)  # Gerar uma distância aleatória dentro do raio

		# Calcular a posição baseada no ângulo e na distância
		var offset = Vector2(cos(angle), sin(angle)) * distance
		
		# Instanciar o exército e definir sua posição
		var army2 = army_scene2.instantiate()  # Instancia o exército
		army2.global_position = global_position + offset  # Define a posição ao redor do personagem
		
		# Adicionar o exército à cena
		get_parent().add_child(army2)  # Adiciona o exército à cena
	else:
		print("Erro: Cena do exército não carregada!")  # Debug

func damage(dano):
	hp -= dano
	flash_red()
	update_health_bar()

func update_health_bar():
	if health_bar:
		health_bar.value = hp

func _on_timer_2_timeout() -> void:
	if player:
		gang_de_army()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "jungcook":  # Verifica se o nome do corpo é "jungcook"
		print("COLIDIDO COM O jungcook")
		damage(10)
		print(hp)

		# Aplica o knockback
		var direction = (global_position - body.global_position).normalized()
		knockback_velocity = direction * KNOCKBACK_FORCE


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func flash_red():
	sprite.modulate = Color(1, 0.3, 0.3)  # Fica avermelhado
	await get_tree().create_timer(0.2).timeout  # Espera 0.2 segundos
	sprite.modulate = Color(1, 1, 1)  # Volta ao normal


func _on_meiotempo_timeout() -> void:
	print("meiotempado")
	gang_de_army2()
	army_timer2.start()


func _on_timerarmy_2_timeout() -> void:
	gang_de_army2()
