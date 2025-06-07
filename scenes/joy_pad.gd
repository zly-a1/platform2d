extends Control


func _ready() -> void:
	$Control4/TouchScreenButton7.hide()
	for portal:Portal in get_tree().get_nodes_in_group("portals"):
		portal.enter.connect(func():
			$Control4/TouchScreenButton7.show()
			)
		portal.exit.connect(func():
			$Control4/TouchScreenButton7.hide()
			)
	for save_point:SavePoint in get_tree().get_nodes_in_group("save_points"):
		save_point.enter.connect(func():
			$Control4/TouchScreenButton7.show()
			)
		save_point.exit.connect(func():
			$Control4/TouchScreenButton7.hide()
			)
	for child:TouchScreenButton in $Control4.get_children():
		child.pressed.connect(func():
			child.modulate.a=0.5
			)
		child.released.connect(func():
			child.modulate.a=1
			)
