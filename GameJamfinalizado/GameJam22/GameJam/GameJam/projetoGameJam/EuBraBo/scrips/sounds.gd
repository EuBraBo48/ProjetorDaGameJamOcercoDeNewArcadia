extends Node2D
class_name sounds



func _on_som_1_timeout():
	$som_1/som1.stop()



func player() -> void:
	
	$som_1/som1.stop()
	print("som para")

	pass
	
func stop() -> void:
	
	$som_1/som1.play()
#	$som_2/som2.stop()
	
	pass	
