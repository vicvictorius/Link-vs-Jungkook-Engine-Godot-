extends Node

@onready var music_player =$AudioStreamPlayer2D   # Referência ao nó AudioStreamPlayer

func _ready():
	# Tocar a música
	music_player.get_stream_playback()
