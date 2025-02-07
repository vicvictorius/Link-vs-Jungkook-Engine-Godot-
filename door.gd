extends Area2D

@export var cena_destino: String = "res://dungeon.tscn"  # Caminho da cena destino

func _on_body_entered(body):
	if body is CharacterBody2D:  # Verifica se o corpo que entrou é o jogador
		get_tree().change_scene_to_file(cena_destino)  # Troca a cena para a cena destino
