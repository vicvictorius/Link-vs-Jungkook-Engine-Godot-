extends Sprite2D  # Ou TextureRect

@onready var timer = $"../Timer"  # Referência ao Timer

func _ready():
	visible = true  # Mostra a imagem
	timer.start()   # Inicia o Timer

func _on_timer_timeout():
	visible = false  # Esconde após 3 segundos
