extends Control  # Muda de Node2D para Control

@onready var hearts = [
	$CanvasLayer/HeartsContainer/hearts,
	$CanvasLayer/HeartsContainer/hearts2,
	$CanvasLayer/HeartsContainer/hearts3,
	$CanvasLayer/HeartsContainer/hearts4
]

func set_hearts(amount: int):
	for i in range(len(hearts)):
		hearts[i].visible = i < amount  # Mostra apenas os corações correspondentes à vida
