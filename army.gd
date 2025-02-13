extends CharacterBody2D

const SPEED = 150.0  # Velocidade do inimigo
var player: Node2D = null
var hp = 20
var sword: Node2D = null

func _ready():
	player = get_node_or_null("../character/link")  # Ajuste o caminho conforme necessário
	sword = get_node_or_null(".../character/sword")
	if player:
		print("Jogador encontrado!")  # Debug
	else:
		print("Jogador não encontrado!")  # Debug

func _physics_process(delta):
	if player:
		# Calcular a direção para o jogador
		var direction = (player.global_position - global_position).normalized()
		# Calcular a distância entre o inimigo e o jogador
		var distance = global_position.distance_to(player.global_position)

		# Definir a velocidade na direção do jogador
		velocity = direction * SPEED  # Multiplica a direção pela velocidade para mover o inimigo
		move_and_slide()  # Move o inimigo utilizando a física

	# Verificar se a vida do inimigo é menor ou igual a 0
	death()

func damage(dano):
	hp -= dano

func death():
	if hp <= 0:
		queue_free()  # Remove o inimigo da cena
		print("army destruído!")


func _on_hitbox_area_entered(area: Area2D):
	if area.is_in_group("sword"):  # Verifica se a área pertence ao grupo "sword"
		damage(20)
