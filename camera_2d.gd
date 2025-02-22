extends Camera2D

@onready var link = $"../link"  # Referência ao objeto "link"
@export var follow_speed: float = 7  # Ajuste a velocidade de suavização
@export var min_y: float = 200  # Limite mínimo de X
@export var max_y: float = 1000  # Limite máximo de X

func _physics_process(delta):
	var target_position = global_position.lerp(link.global_position, delta * follow_speed)
	
	# Restringir a posição X da câmera
	target_position.y = clamp(target_position.y, min_y, max_y)
	
	global_position = target_position
