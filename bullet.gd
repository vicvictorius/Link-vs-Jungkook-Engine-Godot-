extends RigidBody2D

var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	# Define a velocidade inicial do projétil
	linear_velocity = direction * speed

func _on_body_entered(body: Node):
	# Lógica para quando o projétil colidir com algo
	if body.has_method("take_damage"):  # Verifica se o corpo tem um método "take_damage"
		body.take_damage(1)  # Causa dano ao jogador ou inimigo
	queue_free()  # Destroi o projétil após a colisão
