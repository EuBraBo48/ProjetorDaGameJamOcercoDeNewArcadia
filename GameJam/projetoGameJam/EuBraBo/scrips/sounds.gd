extends Node2D
class_name sounds



func _on_som_1_timeout():
	$som_1/som1.stop()
	$som_2/som2.play()

func _on_som_2_timeout():
	$som_1/som1.play()
	$som_2/som2.stop()
