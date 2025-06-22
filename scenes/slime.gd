extends Enemy

signal found()

enum State{
	IDLE,
	WALK,

	HURT,
	DYING,
	ATTACK
}
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var player_checker = $Graphics/PlayerChecker
@onready var floorchker = $Graphics/Floor
@onready var wall = $Graphics/Wall



var is_hurt:bool=false
var can_hurt:bool=true
var back_direction:int=0

func _ready() -> void:
	add_to_group("enemies")
	
func _process(delta: float) -> void:
	pass

func tick_physics(state:State,delta:float):
	match state:
		State.IDLE:
			move(0.0, delta)
		
		State.WALK:
			move(max_speed / 3, delta)
			player_checker.force_raycast_update()
		State.HURT:
			hurt_back(back_direction*max_speed,delta)
		State.ATTACK:
			move(0.0,delta)
		State.DYING:
			move(0.0,delta)

func get_next_state(state:State)->State:
	
	match state:
		State.IDLE:
			if state_machine.state_time>randf_range(1,4):
				return State.WALK
		State.WALK:
			if wall.is_colliding() or not floorchker.is_colliding():
				return State.IDLE
		State.HURT:
			
			if not animation_player.is_playing():
				is_hurt=false
				can_hurt=true
				return State.WALK
		State.DYING:
			if not animation_player.is_playing():
				remove_from_group("enemies")
				queue_free()
		State.ATTACK:
			if not player_checker.is_colliding():
				return State.WALK
	if status.health<=0:
		return State.DYING
	if is_hurt:
		return State.HURT
	
	if player_checker.is_colliding():
		found.emit()
		return State.ATTACK  
	return state
	
func change_state(from:State,to:State):
	print("[%s]:%s->%s"%[Engine.get_physics_frames(),State.keys()[from]if from!=-1 else "START",State.keys()[to]])
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
			GameProcesser.shake_camera(1.0)
			Engine.time_scale=0.01
			await get_tree().create_timer(0.05,true,false,true).timeout
			Engine.time_scale=1
		State.DYING:
			animation_player.play("dying")
			GameProcesser.shake_camera(1.0)
		State.ATTACK:
			animation_player.play("attack")


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
