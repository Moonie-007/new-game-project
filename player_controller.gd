extends CharacterBody2D
class_name PlayerController


@export var speed = 10.0
@export var jump_power = 10.0
var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _input(event):
		
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(9, false)
	else:
		set_collision_mask_value(9, true)

func _physics_process(delta):
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	

	
	# Handle movement
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	
	move_and_slide()
