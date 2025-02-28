extends Sprite2D  # Ou TextureRect

func _ready():
	visible = true  # Mostra a imagem
func _on_timer_timeout():
	visible = false  # Esconde após 3 segundos


func _on_audio_stream_player_2d_finished() -> void:
	visible = false
