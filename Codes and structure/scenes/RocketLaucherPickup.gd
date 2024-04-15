extends Area
export onready var rocketlaucher = preload('res://scenes/RocketLaucher.tscn')
export (Array) onready var carried_guns

#Função que faz coletar o lançador de fuguete
func _on_HealthPickup_body_entered(body):
	if body.is_in_group('Player'):
		for gun in carried_guns:
			if rocketlaucher == gun:
				print('O rocket laucher já está em carried guns')
			else:
				if rocketlaucher != gun:
					print('Colocando o lançador de foguetes na bolsa')
					body.guns_carried.append(rocketlaucher)
					queue_free()
