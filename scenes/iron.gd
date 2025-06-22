extends World


func _process(delta: float) -> void:
	if player.position.y>=321.0:
		player.status.health=0
	for enemy:Enemy in $Enemies.get_children():
		if enemy.position.y>=321.0:
			enemy.status.health=0
