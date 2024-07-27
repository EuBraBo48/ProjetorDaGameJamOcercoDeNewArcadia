extends CanvasLayer

onready var health_bar = $health_bar
onready var hunger_bar = $hunger_bar



export (NodePath) var player_path
onready var player = get_node(player_path)


func _process(delta):
	if player:
		health_bar.value = lerp(health_bar.value, player.health * 100 / player.max_health,0.3)
		hunger_bar.value = lerp(hunger_bar.value, player.hunger * 100 / player.max_hunger, 0.4)
		#print("testehub")


func re_fome () ->  void:
	print("teste fome ")
	if player.hunger >=  10:
			player.hunger = player.hunger - 10
			print("damo")
			print(player.hunger)
			emit_signal("player_stats_changer",self)	
			
				
