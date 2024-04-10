extends Spatial

var can_shoot = true
onready var gunsprite = $CanvasLayer/Control/GunSprite
onready var spawn_location = $Position3D
onready var rocket = preload('res://scenes/Rocket.tscn')

#Função para lançar foguete
func launch_projectile():
	var new_rocket = rocket.instance()
	#print("teste", new_rocket)
	#"Invocando" o foguente no mapa
	get_node("/root/World").add_child(new_rocket)
	new_rocket.global_transform = spawn_location.global_transform

func _process(delta):
	#IF que verificar que o botão "shoot" está sendo pressionado e faz a animação acontece
	if Input.is_action_pressed("shoot") and can_shoot:
		gunsprite.play("shoot")
		launch_projectile()
		can_shoot = false
		yield(gunsprite, 'animation_finished')
		can_shoot = true
		gunsprite.play("idle")

