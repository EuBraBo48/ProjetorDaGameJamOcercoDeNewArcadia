extends Node2D
class_name gerado

onready var zumbis = $"../geradosDeZumbis"
var level = 5.0

export (NodePath) var player_path
onready var player = get_node(player_path)  # ISSO QUI E PAR HUD
#OBS: NÃO ESTA COMPRETO
var TM = 0.0
func _ready():
	$Timer.stop()

var arrayZumbis : Array = [ 
   preload("res://EuBraBo/scenes/zumbiNormal.tscn"),
   preload("res://EuBraBo/scenes/zumbiFogo.tscn"),
   preload("res://EuBraBo/scenes/zumbiTank.tscn"),
   preload("res://EuBraBo/scenes/zumbiExplosion.tscn")]

func tamo() -> void:
 level += 2

 #if TM == 3:
 for i in range(abs(level)):	
		var escolhe_zumbi = arrayZumbis[randi() % arrayZumbis.size()].instance()
		escolhe_zumbi.global_position = Vector2(rand_range(10, 750), rand_range(10, 370))
		zumbis.add_child(escolhe_zumbi)
	



func _on_Timer_timeout():
		TM += 1
