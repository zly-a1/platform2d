extends World


func _ready() -> void:
	super()
	camera_2d.limit_right=3000
	background.size.x+=1000

func _on_dead_line_body_entered(body: Node2D) -> void:
	if body is Player:
		body.status.health=0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.controlled=false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.controlled=true


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player:
		body.controlled=false
		body.state_machine.set_physics_process(false)
		await get_tree().create_timer(1).timeout
		var tween=create_tween()
		tween.tween_property(body,"position",Vector2(1891,-470),0.2)
		await tween.finished
		body.state_machine.set_physics_process(true)
		body.controlled=true
		body.velocity=Vector2(0,0)
		
