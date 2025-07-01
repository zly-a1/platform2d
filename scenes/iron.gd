extends World

var portal_lock:bool=true

func _process(delta: float) -> void:
	if player.position.y>=361.0:
		player.status.health=0
	for enemy:Enemy in $Enemies.get_children():
		if enemy.position.y>=361.0:
			enemy.status.health=0
	if portal_lock:
		var toolged:bool=false
		for child:Switch in $Switches.get_children():
			toolged = toolged and child.toogled
		if toolged==true:
			$Portals/Portal2.show()
			portal_lock=false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		GameProcesser.message_send("无敌时间将缩短！")
		player.super_time.wait_time=2.0
	pass # Replace with function body.


func _on_area_body_exited(body: Node2D) -> void:
	if body is Player:
		GameProcesser.message_send("无敌时间已恢复！")
		player.super_time.wait_time=4.0
	pass # Replace with function body.


func _on_switch_body_entered(body: Node2D) -> void:
	if body is Player:
		GameProcesser.message_send("打开所有开关，传送门才会出现！")
