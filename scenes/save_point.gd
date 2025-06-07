extends Area2D
class_name SavePoint
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_light_2d: PointLight2D = $PointLight2D

signal enter()
signal exit()

var entering:bool=false
var saved:bool=false

func _process(delta: float) -> void:
	if not saved:
		animation_player.play("idle")
	else:
		animation_player.play("saved")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") and entering:
		GameProcesser.save_game()
		saved=true
		var tip=Label.new()
		tip.position=Vector2(get_viewport_rect().position.x+10,get_viewport_rect().end.y-20)
		print(tip.position)
		get_tree().get_first_node_in_group("player").get_node("foreUI/message").add_child(tip)
		tip.text="已存档"
		tip.visible_characters=0
		tip.theme=preload("res://themes/theme.tres") as Theme
		var tween=create_tween()
		tween.tween_property(tip,"visible_characters",3,0.2)
		await get_tree().create_timer(1.0).timeout
		tween=create_tween()
		tween.tween_property(tip,"modulate:a",0,0.2)
		await tween.finished
		tip.queue_free()




func _on_player_entered(body: Node2D) -> void:
	if body is Player:
		entering=true
		enter.emit()
	pass # Replace with function body.


func _on_player_exited(body: Node2D) -> void:
	if body is Player:
		entering=false
		exit.emit()
	pass # Replace with function body.
