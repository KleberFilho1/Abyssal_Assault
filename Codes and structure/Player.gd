extends KinematicBody

#Váriaveis de configurações de escopo global
var velocity = Vector3()
var gravity = -30
var max_speed = 8
var mouse_sensitivility = 0.002

#variáveis das armas


#funções
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_input():
	#Entradas de movimentação
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += -global_transform.basis.x
	input_dir = input_dir.normalized() #cancelar corrida
	return input_dir

#Movimentação da camera
func _unhandled_input(event):
	#Verificando se o mouse está se mexendo
	if event is InputEventMouseMotion:
		#Caso queira o mouse invertido, basta não tira o - em "-event"
		rotate_y(-event.relative.x * mouse_sensitivility)
		#Rotação do "pivô" do Player, nó que é "pai" da câmera e da arma
		$Pivot.rotate_x(event.relative.y * mouse_sensitivility)
		#Delimitando quantos radianos para cima e para baixo o jogador pode ver
		#Basta altera '-1.2, 1.2', caso queira que o jogador olhe a pi/2 radianos.
		$Pivot.rotation.x - clamp($Pivot.rotation.x,-1.2,1.2)
	
func _physics_process(delta):
	#gravidade \ colisão
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)


	
func change_gun(gun):
	pass
	
func _process(delta):
	pass
	
