extends Node2D

onready var anim_dia_noite = $AnimDiaNoite

onready var dia = $dia   
onready var noite = $noite
onready var numero_dia = $numeroDias
var dia4  = 0 # aqui está o dias 


# aqui e o tempo do dias
func _on_dia_timeout():
	dia.stop()
	noite.start()
	anim_dia_noite.play("dia-noite")
	
	

#aqui e o tempo da noite
func _on_noite_timeout():
	dia4 += 1
	noite.stop()
	dia.start()
	print("testenoit")
	anim_dia_noite.play("noite-dia")
	numero_dia.text = str(dia4)
	
	
