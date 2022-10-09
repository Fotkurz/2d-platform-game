extends KinematicBody2D

# move in x axys and can jump (move on y axis)

var velocity = Vector2.ZERO # the currently velocity of the object
var move_speed = 480 # the moving speed
var gravity = 1200 # the gravity strength
var jump_force = -720 # the jumping strength

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity * delta
	
	# checks the move direction
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	velocity.x = move_speed * move_direction
	
	move_and_slide(velocity) # adding the velocity of our object to kinematicbody.move_and_slide.
