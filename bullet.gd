extends RigidBody2D

var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO

@onready var lifetime_timer: Timer = $LifetimeTimer  # Referência ao Timer

func _ready():
	# Define a velocidade inicial do projétil
	linear_velocity = direction * speed
	# Inicia o Timer (se não estiver configurado para autostart)
	lifetime_timer.start()

func _on_body_entered(body: Node):
	# Lógica para quando o projétil colidir com algo
	if body.has_method("take_damage"):  # Verifica se o corpo tem um método "take_damage"
		body.take_damage(1)  # Causa dano ao jogador ou inimigo
	queue_free()  # Destroi o projétil após a colisão

func _on_lifetime_timer_timeout():
	# Destroi o projétil após 3 segundos
	queue_free()
