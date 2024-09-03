extends CanvasLayer
class_name pause_manu

#VARIAVES EM GERSL 
onready var resume_btn = $menu_holder/resume_btn

#FUNÇÃO EM GERAL
func _ready():
	visible = false

 # ESSAS 3 FUNÇÃO SÃO PARA OS BUTÃO DO PAUSE 
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()


func _on_resume_btn_pressed():
	get_tree().paused = false
	visible = false


func _on_quit_btn_pressed():
	get_tree().change_scene("res://EuBraBo/scenes/telaDeTilulo.tscn")
	get_tree().paused = false
	visible = false
	
