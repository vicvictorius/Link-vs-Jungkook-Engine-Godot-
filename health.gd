extends Node  # Ou Area2D/CollisionObject2D
signal died

var current_health = 3

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		died.emit()  # Emite o sinal de morte
