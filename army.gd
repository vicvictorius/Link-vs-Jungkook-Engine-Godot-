extends CharacterBody2D

const SPEED = 150.0  # Velocidade do inimigo
const KNOCKBACK_FORCE = 300.0  # Força do knockback
const KNOCKBACK_DECAY = 0.9  # Redução gradual da velocidade do knockback

var player: Node2D = null
var sword: Node2D = null
var hp = 60
var knockback_velocity: Vector2 = Vector2.ZERO  # Velocidade do knockback

@onready var health_bar: ProgressBar = $Control/HealthBar  # Referência à ProgressBar

# Carrega a cena da explosão
var explosion_scene = preload("res://explosion.tscn")  # Ajuste o caminho para a sua cena de explosão

func _ready():
	# Obtém referências ao jogador e à espada
	player = get_node("/root/Node2D/character/link")  # Ajuste o caminho conforme necessário
	sword = get_node("/root/Node2D/character/sword")  # Ajuste o caminho conforme necessário

	if player:
		print("Jogador encontrado!")  # Debug
	else:
		print("Jogador não encontrado!")  # Debug

	add_to_group("enemies")  # Adiciona o inimigo a um grupo (opcional, para gerenciamento)

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

			# Move o inimigo apenas se estiver longe o suficiente do jogador
			if distance > 10:  # Distância mínima para parar de se mover
				velocity = direction * SPEED
				move_and_slide()

	# Verifica se o inimigo morreu
	death()

func damage(dano):
	hp -= dano
	hp = max(hp, 0)  # Garante que a vida não fique negativa
	update_health_bar()
	print("Dano recebido! Vida restante: ", hp)

func death():
	if hp <= 0:
		# Instancia a explosão
		var explosion = explosion_scene.instantiate()
		get_parent().add_child(explosion)  # Adiciona a explosão ao mundo
		explosion.global_position = global_position  # Posiciona a explosão no mesmo lugar do inimigo

		queue_free()  # Remove o inimigo da cena
		print("Army destruído!")

func update_health_bar():
	if health_bar:
		health_bar.value = hp

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "sword":  # Verifique o nome correto da espada
		damage(20)
		print("pimba")
		print(hp)

		# Aplica o knockback
		var direction = (global_position - body.global_position).normalized()
		knockback_velocity = direction * KNOCKBACK_FORCE
