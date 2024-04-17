extends Area
export onready var rocketlaucher = preload('res://scenes/RocketLaucher.tscn')
export (Array) onready var carried_guns

#Função que faz coletar o lançador de fuguete
func _on_RocketLaucherPickup_body_entered(body):
	if body.is_in_group('Player'):
		if rocketlaucher in   body.carried_guns:
			PlayerStats.change_rocket_ammo(5)
			queue_free()
		else:
			body.carried_guns.append(rocketlaucher)
			queue_free()
			pass
