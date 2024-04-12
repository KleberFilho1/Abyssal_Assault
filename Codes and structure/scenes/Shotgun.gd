extends Spatial



onready var gun_sprite = $CanvasLayer/Control/GunSprite
onready var gun_rays = $GunRays.get_children()
#Selecionando o flash da arma
onready var flash = preload("res://scenes/MuzzleFlash.tscn")
#Selecionado partícula de sangue
onready var blood = preload("res://scenes/Blood.tscn")

var can_shoot = true
export var rapid_fire = false

#Valor do dano da arma
var damage = 8

func _ready():
	gun_sprite.play('idle')

#Função que verificar o acerto no inimigo e faz dá dano
func check_hit():
	for ray in gun_rays:
		#Verificando se o tiro no nó RayCast foi disparado
		if ray.is_colliding():
			#Verificando se o nó RayCast entro em contado com o grupo de nós "enemy"
			if ray.get_collider().is_in_group('Enemy'):
				#Dando dano no inimigo
				ray.get_collider().take_damage(damage)
				#Colocando particulas (de sangue no inimigo morto)
				var new_blood = blood.instance()
				get_node('/root/World').add_child(new_blood)
				new_blood.global_transform.origin = ray.get_collision_point()
				new_blood.emitting = true
				

#Função de flash na boca da arma
func make_flash():
	var f = flash.instance()
	add_child(f)

#Função qeu faz atirar
func _process(delta):
	if Input.is_action_pressed("shoot") and can_shoot and PlayerStats.ammo_shells > 0:
		gun_sprite.play("shoot")
		make_flash()
		check_hit()
		PlayerStats.change_shotgun_ammo(-1)
		can_shoot = false
		
		#Função de redimento
		yield (gun_sprite, 'animation_finished')
		
		can_shoot = true 
		gun_sprite.play("idle")


func _on_Timer_timeout():
	can_shoot = true #Replace with fuction body.
	
