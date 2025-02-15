extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var heart_list : Array[TextureRect]
var health = 4 # Quantidade de vidas inicial


func _ready() -> void:
	var hearts_parent = $"../../CanvasLayer/HeartsContainer"
	for child in hearts_parent.get_children():
		heart_list.append(child)
	print(heart_list)

func take_damage():
	health -= 1
	update_hearts()
	if health <= 0:
		die()

func update_hearts():
	for i in range(len(heart_list)):
		heart_list[i].visible = i < health #Mostra apenas os corações correspondentes a vida

func die():
	queue_free() # remove o link do jogo e reinicia a cena

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()
