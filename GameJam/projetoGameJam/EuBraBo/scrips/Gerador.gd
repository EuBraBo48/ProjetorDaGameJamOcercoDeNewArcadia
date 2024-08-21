extends Node2D
class_name gerado


onready var zumbis = $"../Node"

var contado = 0

export (NodePath) var player_path
onready var player = get_node(player_path)  # ISSO QUI E PAR HUD
#OBS: NÃO ESTA COMPRETO
var zombieCena = preload("res://EuBraBo/scenes/zumbiNormal.tscn")



		

func tamo() -> void:
 for i in range(5):
	 print("TT5555")
	 var instanciaZombie = zombieCena.instance()
	 zumbis.add_child(instanciaZombie)
	 instanciaZombie.position = position
	 contado += 1
