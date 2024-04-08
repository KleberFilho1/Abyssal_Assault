extends KinematicBody


var velocity = Vector3()
var gravity = -30
var max_speed = 8
var mouse_sen = 0.002

#variáveis das armas


#funções
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_input():
	
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += -global_transform.basis.x
	input_dir = input_dir.normalized() #cancelar stafe running
	return input_dir

#Função de fucionamento do mouse
func _unhandled_input(event):
	#Verificando se à movimentação de mouse
	if event is InputEventMouseMotion:
		#Rotação do nó Player
		rotate_y(-event.ralative.y * mouse_sensitivity)
		$Pivot.rotate_x(event.relative.x * mouse_sensitivity)
		$Pivot.rotattion.x = clamp($Pivot.rotation.x, -1.2,1.2)
	
func _physics_process(delta):
	#gravidade
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	
func change_gun(gun):
	pass
	
func _process(delta):
	pass
	
