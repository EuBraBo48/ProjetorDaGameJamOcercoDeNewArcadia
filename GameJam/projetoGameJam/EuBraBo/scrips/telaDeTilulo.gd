extends Control
class_name TelaDeTitulo

#VARIAVES EM GERAL 
onready var new_game = $CanvasDaTelaTitulo/VBoxContainer/newGame

#FUNÇÃO EM GERAL DOS BOTÃOS
func _on_newGame_pressed():
	get_tree().change_scene("res://EuBraBo/scenes/teas.tscn")
	new_game.grab_focus()


func _on_continue_pressed():
	pass #aqui e com o geloze


func _on_optons_pressed():
	pass # não sei fazer


func _on_credits_pressed():
	pass # fazer a cena dos creditos 


func _on_quit_pressed():
	get_tree().quit()
