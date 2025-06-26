class_name  Slime_Bullet
extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const SPEED = 400.0

func _physics_process(delta):
	animation_player.play("flying")
	if is_on_wall():
		Fade()
	move_and_slide()



func Fade():
	animation_player.play("hit")
	await not animation_player.is_playing()
	queue_free()
