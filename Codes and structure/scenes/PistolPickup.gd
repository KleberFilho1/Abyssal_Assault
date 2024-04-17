extends Area
onready var pistol = preload('res://scenes/Pistol.tscn')
export (Array) onready var carried_guns

func _on_PistolPickup_body_entered(body):
	if body.is_in_group('Player'):
		if pistol in  body.carried_guns:
			PlayerStats.change_pistol_ammo(15)
			queue_free()
		else:
			body.carried_guns.append(pistol)
			queue_free()
			pass
