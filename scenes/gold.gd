extends World


func _ready() -> void:
	super()
	camera_2d.limit_right=5000
	background.size.x+=3000

func _on_dead_line_body_entered(body: Node2D) -> void:
	if body is Player:
		body.status.health=0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.controlled=false
		body.velocity.y=0


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.controlled=true
