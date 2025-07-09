extends Control
var pad_scale:=0.5
var knob_sensitivity:float=1.0
var introduced:bool=false

func open_panel():
	for child:TouchScreenButton in $JoyPad/Control4.get_children():
		child.pressed.connect(func():
			child.modulate.a=0.5
			)
		child.released.connect(func():
			child.modulate.a=1
			)
	var config=ConfigFile.new()
	config.load(GameProcesser.CONFIG_PATH)
	pad_scale=config.get_value("Settings","pad_scale",0.5)
	knob_sensitivity=config.get_value("Settings","knob_sensitivity",1.0)
	introduced=config.get_value("Run","introduced",false)
	$VBoxContainer/HBoxContainer/HSlider.value=pad_scale
	$VBoxContainer/HBoxContainer/HSlider2.value=knob_sensitivity
	for child:Control in $JoyPad.get_children():
		child.scale=Vector2(1.0,1.0)*2*pad_scale
	show()




func _on_h_slider_value_changed(value: float) -> void:
	pad_scale=value
	for child:Control in $JoyPad.get_children():
		child.scale=Vector2(1.0,1.0)*2*value


func _on_save_pressed() -> void:
	var config:=ConfigFile.new()
	config.load(GameProcesser.CONFIG_PATH)
	config.set_value("Settings","pad_scale",pad_scale)
	config.set_value("Settings","knob_sensitivity",knob_sensitivity)
	config.save(GameProcesser.CONFIG_PATH)
	



func _on_exit_pressed() -> void:
	hide()


func _on_h_slider_2_value_changed(value: float) -> void:
	knob_sensitivity=value


func _on_h_slider_2_drag_ended(value_changed: bool) -> void:
	if not introduced:
		GameProcesser.message_send("此设置在教程关卡不起效")
