extends World


func _process(delta: float) -> void:
	if player.position.y>=361.0:
		player.status.health=0
	for enemy:Enemy in $Enemies.get_children():
		if enemy.position.y>=361.0:
			enemy.status.health=0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		GameProcesser.message_send("无敌时间将缩短！")
		player.super_time.wait_time=1.0
	pass # Replace with function body.


func _on_area_body_exited(body: Node2D) -> void:
	if body is Player:
		GameProcesser.message_send("无敌时间已恢复！")
		player.super_time.wait_time=4.0
	pass # Replace with function body.
