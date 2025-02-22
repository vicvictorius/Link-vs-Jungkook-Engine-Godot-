extends CharacterBody2D

var rotating = false
var rotation_speed = 25.0  
var base_offset = deg_to_rad(-75)  
var total_rotation = 0.0  
var max_rotation = deg_to_rad(130)  

@onready var link = $"../link"  
@onready var sprite = $Sprite2D  
@onready var collision = $CollisionShape2D  
@onready var area2d = $Area2D

signal hit_something(body: Node)  # Sinal personalizado

func _ready():
	add_to_group("sword")  # Adiciona a espada ao grupo "sword"

func _physics_process(delta):
	global_position = link.global_position  

	if Input.is_action_pressed("mouse_right"):
		rotating = false
		total_rotation = 0.0
		sprite.visible = false
		collision.disabled = true
		area2d.monitoring = false
		area2d.monitorable = false
		return

	var target_angle = (get_global_mouse_position() - global_position).angle() + base_offset
	
	if rotating:
		var rotation_amount = rotation_speed * delta
		rotation += rotation_amount
		total_rotation += abs(rotation_amount)  
		
		sprite.visible = true 
		collision.disabled = false  
		area2d.monitoring = true
		area2d.monitorable = true
		
		if total_rotation >= max_rotation:
			rotating = false
			total_rotation = 0.0  
	else:
		rotation = target_angle  
		sprite.visible = false  
		collision.disabled = true  
		area2d.monitoring = false
		area2d.monitorable = false

func _input(event): 
	if Input.is_action_pressed("mouse_right"):
		return

	if Input.is_action_just_pressed("mouse_left"):
		rotating = true
		total_rotation = 0.0
