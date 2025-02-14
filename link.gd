extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var health = $link/Health # Referência ao nó de vida
@onready var hitbox = $link/Hitbox # Referência ao Area2D de colisão
var hp = 150

func _ready() -> void:
	health.died.connect(death)  # Conecta diretamente à função death
	hitbox.body_entered.connect(_on_hitbox_body_entered)

func _on_hitbox_body_entered(body):
	if body.name == "jungcook":
		take_damage()

func take_damage():
	health.take_damage(1)  # Aplica 1 de dano

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED if direction != 0 else 0

	death()
	move_and_slide()

func death():
	if hp <= 0:
		queue_free()
		print("Personagem destruído!")

func damage(dano):
	hp -= dano

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "link":
		print("COLIDIDO COM O jogador")
		damage(10)
		print(hp)
