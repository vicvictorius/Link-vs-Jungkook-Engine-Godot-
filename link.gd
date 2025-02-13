extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var heart_list : Array[TextureRect]
var health = 5

func _ready() -> void:
	var hearts_parent = $"../Health_Bar/HBoxContainer"
	for child in hearts_parent.get_children():
		heart_list.append(child)
	print(heart_list)

func take_damage():
	if health > 0:
		health -= 1
		$"../Damage".play("damaged")
		update_heart_display()

func update_heart_display():
	for i in range(heart_list.size()):
		heart_list[i].visible = i < health

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
