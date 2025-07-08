extends Puzzle
@onready var animation_player: AnimationPlayer = $AnimationPlayer
enum Directions{
	LEFT,
	TOP,
	RIGHT,
	BOTTOM,
	H_BOTH,
	V_BOTH,
	BOTH
}
@export var direction:=Directions.RIGHT

func _process(delta: float) -> void:
	animation_player.play("idle")

func generate_puzzle_bullet(direction:Vector2i)->Puzzle_Bullet:
	var a:=preload("res://scenes/puzzle_bullet.tscn").instantiate()
	a.position=position
	a.velocity.x=direction.x*a.SPEED
	a.velocity.y=direction.y*a.SPEED
	return a

func shoot():
	if direction!=Directions.H_BOTH and direction!=Directions.V_BOTH and direction!=Directions.BOTH:
		if direction==Directions.LEFT:
			var a = generate_puzzle_bullet(Vector2i(-1,0))
			get_parent().get_parent().add_child(a,true)	
		if direction==Directions.RIGHT:
			var a = generate_puzzle_bullet(Vector2i(1,0))
			get_parent().get_parent().add_child(a,true)	
		if direction==Directions.TOP:
			var a = generate_puzzle_bullet(Vector2i(0,-1))
			get_parent().get_parent().add_child(a,true)	
		if direction==Directions.BOTTOM:
			var a = generate_puzzle_bullet(Vector2i(0,1))
			get_parent().get_parent().add_child(a,true)	
		
	else:
		if direction==Directions.H_BOTH:
			for i in range(2):
				if i==0:
					var a=generate_puzzle_bullet(Vector2(-1,0))
					get_parent().get_parent().add_child(a,true)	
				if i==1:
					var a=generate_puzzle_bullet(Vector2(1,0))
					get_parent().get_parent().add_child(a,true)	
					
		if direction==Directions.V_BOTH:
			for i in range(2):
				if i==0:
					var a=generate_puzzle_bullet(Vector2(0,-1))
					get_parent().get_parent().add_child(a,true)	
				if i==1:
					var a=generate_puzzle_bullet(Vector2(0,1))
					get_parent().get_parent().add_child(a,true)	
						
		if direction==Directions.BOTH:
			for i in range(4):
				if i==0:
					var a=generate_puzzle_bullet(Vector2(-1,0))
					get_parent().get_parent().add_child(a,true)	
				if i==1:
					var a=generate_puzzle_bullet(Vector2(1,0))
					get_parent().get_parent().add_child(a,true)
				if i==2:	
					var a=generate_puzzle_bullet(Vector2(0,-1))
					get_parent().get_parent().add_child(a,true)
				if i==3:
					var a=generate_puzzle_bullet(Vector2(0,1))
					get_parent().get_parent().add_child(a,true)	
					
	
