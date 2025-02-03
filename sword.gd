extends Node2D

var tween: Tween
@onready var link = $"../link"  # Referência ao objeto "link"

func _ready():
	tween = create_tween()  # Cria um novo Tween

func _physics_process(delta):
	global_position = link.global_position  # Segue a posição do link
	
	# Faz o objeto olhar para o mouse
	look_at_mouse()

	# Rotação adicional quando o botão esquerdo do mouse é pressionado
	if Input.is_action_just_pressed("mouse_left"):
		rotation += deg_to_rad(80)  # Converte 80 graus para radianos

func look_at_mouse():
	# Obtém a posição do mouse na tela
	var mouse_position = get_global_mouse_position()
	
	# Calcula o ângulo entre a posição do personagem e a posição do mouse
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()
	
	# Aplica a rotação ao personagem com um offset de -90 graus
	rotation = angle + deg_to_rad(-90)
