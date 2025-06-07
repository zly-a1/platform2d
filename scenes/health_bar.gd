extends HBoxContainer
class_name HealthBar

@export var status:Status
@onready var based_bar = $VBoxContainer/Bar/BasedBar

@onready var bar = $VBoxContainer/Bar
@onready var bar_2 = $VBoxContainer/Bar2

func set_status(stat:Status):
	status=stat

# Called when the node enters the scene tree for the first time.
func _ready():
	status.health_changed.connect(update_health)
	status.energy_changed.connect(update_energy)
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_health():
	bar.value=bar.max_value/status.max_health*status.health
	create_tween().tween_property(based_bar,"value",bar.value,0.2)

func update_energy():
	bar_2.value=bar_2.max_value/status.max_energy*status.energy
