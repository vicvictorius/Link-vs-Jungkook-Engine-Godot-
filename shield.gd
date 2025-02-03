extends Node2D

@onready var tween: Tween = null  # Variável para armazenar o Tween

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse_right"):
		rotate_shield(-90)
	elif Input.is_action_just_released("mouse_right"):
		rotate_shield(90)

func rotate_shield(angle):
	if tween and tween.is_running():  # Para evitar conflitos
		tween.kill()

	tween = get_tree().create_tween()  # Cria um novo Tween
	tween.tween_property(self, "rotation_degrees", rotation_degrees + angle, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
