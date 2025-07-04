extends Puzzle
@onready var animation_player: AnimationPlayer = $AnimationPlayer
enum Directions{
	LEFT,
	TOP,
	RIGHT,
	BOTTOM
}
@export var direction:=Directions.RIGHT

func _process(delta: float) -> void:
	animation_player.play("idle")

func shoot():
	var a:=preload("res://scenes/puzzle_bullet.tscn").instantiate()
	a.position=position
	if direction==Directions.LEFT:
		a.velocity.x=-1*a.SPEED
		a.velocity.y=0
	if direction==Directions.RIGHT:
		a.velocity.x=a.SPEED
		a.velocity.y=0
	if direction==Directions.TOP:
		a.velocity.x=0
		a.velocity.y=-1*a.SPEED
	if direction==Directions.BOTTOM:
		a.velocity.x=0
		a.velocity.y=a.SPEED
	get_parent().get_parent().add_child(a,true)
