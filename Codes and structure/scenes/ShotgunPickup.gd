extends Area
export onready var shotgun = preload("res://scenes/Shotgun.tscn")
export (Array) onready var carried_guns

func _on_ShotgunPickup_body_entered(body):
	if body.is_in_group('Player'):
		if shotgun in  body.carried_guns:
			PlayerStats.change_shotgun_ammo(5)
			queue_free()
		else:
			body.carried_guns.append(shotgun)
			queue_free()
			
