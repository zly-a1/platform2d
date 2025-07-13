extends Enemy

enum State{
	IDLE,
	WALK,
	HURT,
	DYING,
	ATTACK
}
@onready var wall: RayCast2D = $Graphics/Wall
@onready var floorchker: RayCast2D = $Graphics/Floor
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_checker: RayCast2D = $Graphics/PlayerChecker

var is_hurt:bool=false
var can_hurt:bool=true
var back_direction:int=0
var bullet=preload("res://scenes/slime_bullet.tscn")

func _ready() -> void:
	add_to_group("enemies")
	
func _process(delta: float) -> void:
	super(delta)

func tick_physics(state:State,delta:float):
	match state:
		State.IDLE:
			move(0.0, delta)
		
		State.WALK:
			move(max_speed / 2, delta)
		State.HURT:
			hurt_back(back_direction*max_speed,delta)
		State.DYING:
			move(0.0,delta)
		State.ATTACK:
			move(0.0,delta)

func get_next_state(state:State)->State:
	
	match state:
		State.IDLE:
			if state_machine.state_time>randf_range(0,1):
				return State.WALK
		State.WALK:
			if wall.is_colliding() or not floorchker.is_colliding():
				return State.IDLE
			if player_checker.is_colliding() and randi_range(0,1)==1:
				return State.ATTACK
		State.HURT:
			
			if not animation_player.is_playing():
				is_hurt=false
				can_hurt=true
				return State.ATTACK
		State.DYING:
			if not animation_player.is_playing():
				remove_from_group("enemies")
				queue_free()
		State.ATTACK:
			if state_machine.state_time>randf_range(1,2) and not player_checker.is_colliding():
				return State.WALK
				
	if status.health<=0:
		return State.DYING
	if is_hurt:
		return State.HURT
	return state
	
func change_state(from:State,to:State):
	
	match to:
		State.IDLE:
			animation_player.play("idle")
			if wall.is_colliding():
				direction*=-1
		State.WALK:
			animation_player.play("walk")
			if not floorchker.is_colliding():
				direction*=-1
				floorchker.force_raycast_update()
		State.HURT:
			animation_player.play("hurt")
			GameProcesser.shake_camera(5.0)
			Engine.time_scale=0.01
			await get_tree().create_timer(0.05,true,false,true).timeout
			Engine.time_scale=1
		State.DYING:
			animation_player.play("dying")
			GameProcesser.shake_camera(1.0)
			var pl=get_tree().get_first_node_in_group("player") as Player
			pl.status.energy=80
		State.ATTACK:
			animation_player.play("walk")
			direction=1 if (get_tree().get_first_node_in_group("player") as Player).position.x>=position.x else -1
			shoot()
			player_checker.force_raycast_update()

func _on_hurter_hurt(hitter):
	if can_hurt:
		if status.health>0:
			status.health-=1
		is_hurt=true
		can_hurt=false
		var hit_ter:=hitter.owner as CharacterBody2D
		SoundManager.play_sfx("Hurt")
		back_direction=-1 if (position- hit_ter.position).normalized().x<0 else 1
	
	if hitter.owner is Bullet:
		var bullet=hitter.owner as Bullet
		bullet.Fade()

func shoot():
	var b:=bullet.instantiate()	as Slime_Bullet
	b.position=position
	b.velocity.x=direction*b.SPEED
	b.direction=-direction
	get_parent().get_parent().add_child(b)
	SoundManager.play_sfx("Slash")
