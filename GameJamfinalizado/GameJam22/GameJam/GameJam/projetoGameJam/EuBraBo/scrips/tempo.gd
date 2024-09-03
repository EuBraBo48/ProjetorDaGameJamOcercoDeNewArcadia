extends Node2D
class_name Tempo

#VARIAVES EM GERAL 
onready var anim_dia_noite = $AnimDiaNoite

onready var dia = $dia   
onready var noite = $noite

# aqui e o tempo do dias
func _on_dia_timeout():
	dia.stop()
	noite.start()
	anim_dia_noite.play("dia-noite")

#aqui e o tempo da noite
func _on_noite_timeout():
#	diaTotal += 1
	noite.stop()
	dia.start()
	anim_dia_noite.play("noite-dia")
#	numero_dias.text = str(diaTotal)
