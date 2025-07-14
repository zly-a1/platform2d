class_name Enemy
extends CharacterBody2D

enum Direction {
	LEFT = -1,
	RIGHT = +1,
}

@onready var status: Status = $Status

@export var direction := Direction.LEFT:
	set(v):
		direction = v
		if not is_node_ready():
			await ready
		graphics.scale.x = -direction
var max_speed: float = 180
var acceleration: float = 2000

var default_gravity := ProjectSettings.get("physics/2d/default_gravity") as float

@onready var graphics: Node2D = $Graphics
@onready var hurter = $Graphics/Hurter
@onready var hitter = $Graphics/Hitter

@onready var state_machine: Node = $StateMachine


func move(speed: float, delta: float) -> void:
	velocity.x = move_toward(velocity.x, speed * direction, acceleration * delta)
	velocity.y += default_gravity * delta
	
	move_and_slide()

func hurt_back(speed:float,delta:float) -> void:
	velocity.x = move_toward(velocity.x,speed,acceleration*delta)
	velocity.y *=default_gravity*delta
	
	move_and_slide()


func _process(delta: float) -> void:
	$Graphics/HealthBar.max_value=status.max_health
	$Graphics/HealthBar.scale=Vector2(-0.8*direction,0.8)
	$Graphics/HealthBar.value=status.health


func _on_hurter_hurt(hitter: Variant) -> void:
	var damage_num=preload("res://scenes/damage_number.tscn").instantiate()
	var a:float=1/float(status.max_health)
	damage_num.num=int(a*100)
	damage_num.position=position
	get_parent().get_parent().add_child(damage_num)
