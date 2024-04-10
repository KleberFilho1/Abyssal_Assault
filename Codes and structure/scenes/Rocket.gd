extends Area

var rocket_speed = 30
var rocket_damage = 25
#var rocket_splash = 25

func deal_damage():
	var enemies = get_overlapping_bodies()
	#Verificando e provando dano do foguete
	for body in enemies:
		if body.is_in_group("Enemy"):
			body.take_damage(rocket_damage)
	enemies = $SplashDamage.get_overlapping_bodies()
	#Verificando e provocando dano na explosão do foguete
	for body in enemies:
		if body.is_in_group("Enemy"):
			body.take_damage(rocket_damage)

func _process(delta):
	#Vetor velocidade ddo foguete
	translate(Vector3.FORWARD * rocket_speed * delta)	

func _on_Rocket_body_entered(body):
	if body.is_in_group('Player'):
		return
	set_process(false)
	$AnimatedSprite3D.play("explode")
	deal_damage()
	yield($AnimatedSprite3D, 'animation_finished')
	queue_free()


func _on_SplashDamage_body_entered(body):
	pass # Replace with function body.
