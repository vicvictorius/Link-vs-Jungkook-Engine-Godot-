extends Node2D

var rotating = false
var rotation_speed = 25.0  
var base_offset = deg_to_rad(-75)  
var total_rotation = 0.0  
var max_rotation = deg_to_rad(130)  

@onready var link = $"../link"  
@onready var sprite = $Sprite2D  
@onready var collision = $CollisionShape2D  

signal hit_something(body: Node)  # Sinal personalizado

func _ready():
	add_to_group("sword")  # Adiciona a espada ao grupo "sword"

func _physics_process(delta):
	global_position = link.global_position  

	# Se o botão direito do mouse estiver pressionado, a espada não faz nada
	if Input.is_action_pressed("mouse_right"):
		rotating = false
		total_rotation = 0.0
		sprite.visible = false
		collision.disabled = true
		return

	var target_angle = (get_global_mouse_position() - global_position).angle() + base_offset
	
	if rotating:
		var rotation_amount = rotation_speed * delta
		rotation += rotation_amount
		total_rotation += abs(rotation_amount)  
		
		sprite.visible = true  
		collision.disabled = false  
		
		if total_rotation >= max_rotation:
			rotating = false
			total_rotation = 0.0  
	else:
		rotation = target_angle  
		sprite.visible = false  
		collision.disabled = true  

func _input(event): 
	# Se o botão direito do mouse estiver pressionado, o ataque não inicia
	if Input.is_action_pressed("mouse_right"):
		return

	if Input.is_action_just_pressed("mouse_left"):
		rotating = true
		total_rotation = 0.0

func _on_area_entered(area: Area2D) -> void:
	emit_signal("hit_something", area)  # Notifica que a espada acertou algo
