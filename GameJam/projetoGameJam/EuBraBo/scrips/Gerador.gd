extends Node2D
class_name gerado


onready var zumbis = $"../geradosDeZumbis"
var level = 5.0

export (NodePath) var player_path
onready var player = get_node(player_path)  # ISSO QUI E PAR HUD
#OBS: NÃO ESTA COMPRETO


var arrayZumbis : Array = [ 
   preload("res://EuBraBo/scenes/zumbiNormal.tscn"),
   preload("res://EuBraBo/scenes/zumbiFogo.tscn"),
   preload("res://EuBraBo/scenes/zumbiTank.tscn"),
   preload("res://EuBraBo/scenes/zumbiExplosion.tscn")
]


func _ready():
	emit_signal("tamo")


func tamo() -> void:
 level += 0.6	
 for i in range(level):
	 
	 var escolhe_zumbi = arrayZumbis[randi() % arrayZumbis.size()].instance()
	 escolhe_zumbi.global_position = Vector2(rand_range(100, 200), rand_range(95, 300))
	 zumbis.add_child(escolhe_zumbi)
