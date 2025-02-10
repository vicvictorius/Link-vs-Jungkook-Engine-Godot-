extends Camera2D

@onready var link = $"../link"  # Referência ao objeto "link"
@export var follow_speed: float = 7  # Ajuste a velocidade de suavização

func _physics_process(delta):
	global_position = global_position.lerp(link.global_position, delta * follow_speed)
