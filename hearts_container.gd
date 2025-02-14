extends Control  # Muda de Node2D para Control

@onready var hearts = [
	$hearts,
	$hearts2,
	$hearts3,
	$hearts4
]

func set_hearts(amount: int):
	for i in range(len(hearts)):
		hearts[i].visible = i < amount  # Mostra apenas os corações correspondentes à vida
