extends KinematicBody2D


var velocity = Vector2.ZERO

var move_speed = 480
var gravity = 1200
var jump_force = -780 
var is_grounded # checks wether character is touching ground
onready var raycasts = $raycasts # comes from Node2D.Raycast we added

func _physics_process(delta: float) -> void:
	velocity.y += delta * gravity
	
#	if Input.is_action_just_pressed("jump") and is_grounded:
#		velocity.y = jump_force / 2
	
	_get_input()
	 
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_ground()
	
	_set_animation()
	
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))		
#	velocity.x = move_speed * move_direction
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force / 2

func _check_is_ground():
	for raycast in raycasts.get_children(	):
		if raycast.is_colliding():
			return true
		return false
	 
func _set_animation():
	var anim = "Idle"
	
	if !is_grounded:
		anim = "Jump"
	elif velocity.x != 0:
		anim = "Run"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)
