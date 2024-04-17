extends Area
export (int) var health_val = 20

#FUnção que faz coletar e regenera vida
func _on_HealthPickup_body_entered(body):
	if body.is_in_group('Player'):
		PlayerStats.change_health(health_val)
		queue_free()
