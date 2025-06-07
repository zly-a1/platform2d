extends World


func _process(delta: float) -> void:
	if player.position.y>=321.0:
		player.status.health=0
