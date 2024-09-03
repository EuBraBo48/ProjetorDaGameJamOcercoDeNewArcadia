extends Control
class_name TelaDeTitulo

#VARIAVES EM GERAL 
onready var menu = $CanvasDaTelaTitulo/menu/newGame
onready var tween: Tween = $Tween

func _ready() -> void:
	var transi = tween.create_tween()
	transi.tween_property($CanvasLayer/Panel, "modulate", Color(0), 2)
	
	yield(transi, "finished")
	$CanvasLayer/Panel.queue_free()

#FUNÇÃO EM GERAL DOS BOTÃOS
func _on_newGame_pressed():
	get_tree().change_scene("res://luan/cenas/diálogo.tscn")
	menu.grab_focus()
 

func _on_options_pressed():
	$options.show()
	$CanvasDaTelaTitulo.hide()
	menu.grab_focus()
	pass 

func _on_credits_pressed():
   get_tree().change_scene("res://EuBraBo/scenes/creditos.tscn")
   menu.grab_focus() 

func _on_quit_pressed():
	get_tree().quit()

#---Opções---#

func _on_fullscreen_pressed():
	var current_mode = OS.window_fullscreen
	if current_mode:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true

func _on_Borderless_pressed(toggled_on):
	OS.set_borderless_window(toggled_on)
	OS.center_window()


func _on_VOLTA_pressed():
  get_tree().change_scene("res://EuBraBo/scenes/telaDeTilulo.tscn")
