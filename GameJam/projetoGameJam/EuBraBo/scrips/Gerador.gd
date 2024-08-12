extends Node2D
class_name gerado

#OBS: NÃO ESTA COMPRETO
var zombieCena = preload("res://EuBraBo/scenes/zumbiNormal.tscn")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_page_down") : 
		var instanciaZombie = zombieCena.instance()
		get_parent().add_child(instanciaZombie)
