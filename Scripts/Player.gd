extends KinematicBody2D


export var gravity = 600
export var walk_speed = 200
export var jump_force = 500

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -walk_speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = walk_speed
	else:
		velocity.x = 0
		# smoothen the stop
		# velocity.x = lerp(velocity.x, 0, 0.1)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	 
	velocity = move_and_slide(velocity, Vector2.UP)
	
