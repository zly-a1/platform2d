extends CharacterBody2D
class_name Fruit
enum FruitType{
	HEALTH,
	ENERGY
}
@export var type:FruitType=FruitType.HEALTH

var tween_started:bool=false

func _process(delta: float) -> void:
	var player:=get_tree().get_first_node_in_group("player") as Player
	if player and (global_position-player.global_position).length()<=20:
		if tween_started:
			return
		tween_started=true
		player.status.health+=1
		var tween=create_tween()
		tween.tween_property($AnimatedSprite2D,"scale",Vector2(0.0,0.0),0.2)
		await tween.finished
		queue_free()
