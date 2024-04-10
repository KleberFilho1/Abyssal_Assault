extends KinematicBody

#Obtendo todas as cenas que compõem o jogo.
#As váriaveis do tipo onready fazem com que o programa só seja executado caso primeiro as váriaveis onready sejam executdas
onready var nav = get_tree().get_nodes_in_group('NavMesh')[0]
onready var player = get_tree().get_nodes_in_group('Player')[0]

var path = [] #Assegura as coordenadas do caminho (NavMash) do inimigo até o jogador
var path_index = 0 #Acompanha qual coordenada precisa ir
var speed = 3 #Velocidade do inimigo
var health = 20 #Quantidade de vida do inimigo

var move = true

func _ready():
	pass

func take_demage(dmg_amount): #Função que faz o inimigo levar dano
	health -= dmg_amount
	if health <= 0: #Caso a vida do inimigo seja 0, ele morre
		death()
		return
	#Aperfeiçoamentos na animação
	move = false
	$AnimatedSprite3D.play("hit")
	yield($AnimatedSprite3D, "animation_finished")
	#$AnimatedSprite3D.play("walking")
	move = true
	
func _physics_process(delta):
	if path_index < path.size():
		var direction = (path[path_index] - global_transform.origin)
		if direction.length() < 1: #Vetor tridimensional que representar uma direção, distância e módulo 
			path_index += 1
		else:
			if move:
				$AnimatedSprite3D.play("walking")##
				move_and_slide(direction.normalized() * speed, Vector3.UP)
	else:
		find_path(player.global_transform.origin)

func find_path(target): #Função para contrar o caminho: "guair o inimigo até o jogador".
	path = nav.get_simple_path(global_transform.origin, target) #Essa função serve básicamente serve para encontrar o caminho entre dois pontos distintos
	path_index = 0
	
func death():
	set_process(false)
	set_physics_process(false)
	$CollisionShape.disabled = true
	#Variaváveis de animações depedendo do "grau" de dano que o inimigo levar
	if health < -20:
		$AnimatedSprite3D.play("explode")
	else:
		$AnimatedSprite3D.play("die")

func shoot(target):
	pass
