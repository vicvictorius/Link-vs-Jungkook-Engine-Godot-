extends Button
@export var cena_destino: String = "res://Spawn.tscn"  # Caminho da cena destino


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.d.


func reset_game():
	print("button pressed")
	get_tree().change_scene_to_file(cena_destino)


func _on_button_down() -> void:
	reset_game()
