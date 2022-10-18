extends KinematicBody2D


var velocity = Vector2.ZERO

var move_speed = 240
var gravity = 1200
var jump_force = -780
var is_grounded
onready var raycasts = $raycasts

func _physics_process(delta: float) -> void:
	velocity.y += delta * gravity
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_force / 2
	
	_get_input()
	 
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_ground()
	
func _get_input():
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))		
	velocity.x = move_speed * move_direction
	
	if move_direction != 0:
		$texture.scale.x = move_direction

		
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
		return false
	 
