extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("pimbadores")  # Adiciona este nó ao grupo "inimigos"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
