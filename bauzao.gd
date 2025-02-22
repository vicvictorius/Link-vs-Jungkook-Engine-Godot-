extends Area2D

var is_open: bool = false  # O baú começa fechado
@onready var sprite = $Sprite  # Referência ao Sprite (ou AnimatedSprite2D)
@onready var collision = $CollisionShape2D  # Referência à colisão

func _ready():
	# Define o sprite inicial (baú fechado)
	sprite.texture = preload("res://Baufechado.png")  # Troque o caminho conforme necessário

func _input_event(viewport, event, shape_idx):
	# Verifique se o botão do mouse foi pressionado
	if event is InputEventMouseButton and event.pressed:
		open_chest()  # Chama a função para abrir o baú

func open_chest():
	# Altere o estado do baú para aberto e mude o sprite
	if is_open:
		return  # Evita reabrir o baú se já estiver aberto
	
	is_open = true
	sprite.texture = preload("res://Bauaberto.png")  # Troque o caminho para o sprite do baú aberto
	# Aqui você pode colocar a lógica para spawnar itens ou outras ações
