extends Control

const SETTING_FILE="user://config.ini"
var is_guichu:bool=false

func load_settings():
	var settings=ConfigFile.new()
	settings.load(SETTING_FILE)
	is_guichu=settings.get_value("Settings","is_guichu",false)
	$VBoxContainer/GridContainer/CheckButton.button_pressed=is_guichu
func apply_settings():
	var settings=ConfigFile.new()
	settings.load(SETTING_FILE)
	settings.set_value("Settings","is_guichu",is_guichu)
	settings.save(SETTING_FILE)
	(SoundManager.get_node("BGM/GameOver") as AudioStreamPlayer).stream=preload("res://assets/bgm/Turn All The Lights On.mp3") if is_guichu else preload("res://assets/bgm/game_over.mp3")
	(SoundManager.get_node("SFX/Hurt") as AudioStreamPlayer).stream=preload("res://assets/sfx/niganma.mp3") if is_guichu else preload("res://assets/sfx/hurt.mp3")
	(SoundManager.get_node("SFX/Slash") as AudioStreamPlayer).stream=preload("res://assets/sfx/zhiyin.ogg") if is_guichu else preload("res://assets/sfx/07_human_atk_sword_1.ogg")
	(SoundManager.get_node("SFX/Attack") as AudioStreamPlayer).stream=preload("res://assets/sfx/ahha.ogg") if is_guichu else preload("res://assets/sfx/attack1.mp3")
	(SoundManager.get_node("SFX/Flash") as AudioStreamPlayer).stream=preload("res://assets/sfx/zhiyin.ogg") if is_guichu else preload("res://assets/sfx/flash.mp3")
	
func open_panel():
	show()
	$VBoxContainer/Exit.grab_focus()
	load_settings()

	
	







func _on_exit_pressed() -> void:
	hide()
	(self.get_parent().get_node("Panel/Panel/Settings") as Button).grab_focus()


func _on_check_button_pressed() -> void:
	SoundManager.play_sfx("Press")
	is_guichu=$VBoxContainer/GridContainer/CheckButton.button_pressed
	apply_settings()


func _on_button_pressed() -> void:
	get_parent().get_node("JoyPadEditable").open_panel()
