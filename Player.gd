extends KinematicBody

export var speed = 18
export var acceleration = 5
export var gravity = 0.98 
export var jump_power = 30
export var mouse_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0


func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		
		var x_delta = event.relative.y*mouse_sensitivity
		if camera_x_rotation+x_delta>-90 and camera_x_rotation+x_delta<90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation+= x_delta


func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	var direction = Vector3()
	if Input. is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input. is_action_pressed("move_backward"):
		direction += head_basis.z
	
	
	if Input. is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input. is_action_pressed("move_right"):
		direction += head_basis.x
		
		
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction*speed, acceleration*delta)
	
	velocity = move_and_slide(velocity)
