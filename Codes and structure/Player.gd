extends KinematicBody

#Váriaveis de configurações de escopo global
var velocity = Vector3()
var gravity = -30
var max_speed = 8
var mouse_sensitivility = 0.002
var life = true

#variáveis das armas
#Armas
onready var pistol = preload('res://scenes/Pistol.tscn')
onready var shotgun = preload("res://scenes/Shotgun.tscn")
onready var uzi = preload('res://scenes/Uzi.tscn')
onready var rocketlaucher = preload('res://scenes/RocketLaucher.tscn')
#Menu de armas
var current_gun = 0
#Colocar nova arma no vetor "carried_guns"
onready var carried_guns = [pistol, shotgun, uzi]

#funções
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	change_gun(0)

#Movimentação
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
		$Pivot.rotation.x - clamp($Pivot.rotation.y,-1.2,1.2)
	
#Função de eventos físicos (Gravidade e colisão)
func _physics_process(delta):
	#gravidade \ colisão
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

#Função que faz animação de trocar de arma
func change_gun(gun):
	$Pivot/Gun.get_child(0).queue_free()
	var new_gun = carried_guns[gun].instance()
	$Pivot/Gun.add_child(new_gun)
	PlayerStats.current_gun = new_gun.name

#Função que faz mudar de arma (ou adicionar mais uma arma)
func _process(delta):
	if Input.is_action_just_pressed('next_gun'):
		current_gun += 1
		if current_gun > len(carried_guns)-1:
			current_gun = 0
		change_gun(current_gun)
	elif Input.is_action_just_released("prev_gun"):
		current_gun -= 1
		if current_gun < 0:
			current_gun = len(carried_guns)-1
		change_gun(current_gun)
		
	#Abridor de porta
	elif Input.is_action_just_pressed('use'):
		if $InteractCast.is_colliding():
			if $InteractCast.get_collider().is_in_group("Door"):
				$InteractCast.get_collider().get_node('AnimationPlayer').play('OpenDoor')
				#print('Open the door')
			elif $InteractCast.get_collider().is_in_group('Button'):
				$InteractCast.get_collider().get_node('AnimationPlayer').play('AtivandoButton')
				print('Você apertou no botão')
				$ChangeLevel.start()
				pass
				
#Função que faz a tela de morte aparecer
func screen_death():
	pass

#Ganbirra
func _on_Reset_timeout() -> void:
	if PlayerStats.health == 0:
		$Trasition/Animation.play("trasition")
		get_tree().reload_current_scene()
		PlayerStats.reset()
		$Trasition/Animation.play("trasition2")
	else:
		pass

func _on_ChangeLevel_timeout():
	get_tree().change_scene("res://scenes/WorldTest.tscn")
	PlayerStats.reset()
	pass
