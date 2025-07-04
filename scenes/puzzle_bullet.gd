class_name Puzzle_Bullet
extends CharacterBody2D
@onready var sprite_2d = $Sprite2D

@export var fading:bool=false
const SPEED = 200.0

func _physics_process(delta):
	sprite_2d.rotate(10)
	if is_on_wall() or is_on_ceiling() or is_on_floor():
		Fade()
	move_and_slide()



func Fade():
	if fading:
		return
	fading=true
	var tween=create_tween()
	tween.tween_property(self,"modulate:a",0.0,0.2)
	await tween.finished	
	queue_free()


func _on_hitter_body_entered(body: Node2D) -> void:
	Fade()
