extends World


func _on_dead_line_body_entered(body: Node2D) -> void:
	if body is Player:
		body.status.health=0
	pass # Replace with function body.
