extends KinematicBody

var velocity = Vector3()
var gravity = -30
var max_speed = 8
var mouse_sen = 0.002

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("stafe_left"):
		input_dir += global_transform.basis.x
	if Input.is_action_pressed("stafe_right"):
		input_dir += global_transform.basis.x
	
func _unhandled_input(event):
	pass
	
func _physics_process(delta):
	#gravidade
	velocity += gravity * delta
	
func change_gun(gun):
	pass
	
func _process(delta):
	pass
	
