extends Control
class_name TelaDeTitulo

#VARIAVES EM GERAL 
onready var v_box_container = $CanvasDaTelaTitulo/VBoxContainer

#FUNÇÃO EM GERAL DOS BOTÃOS
func _on_newGame_pressed():
	get_tree().change_scene("res://EuBraBo/scenes/teas.tscn")


func _on_continue_pressed():
	
	pass 

func _on_options_pressed():
	$options.show()
	$CanvasDaTelaTitulo.hide()
	pass 

func _on_credits_pressed():
   get_tree().change_scene("res://EuBraBo/scenes/creditos.tscn")
   

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
