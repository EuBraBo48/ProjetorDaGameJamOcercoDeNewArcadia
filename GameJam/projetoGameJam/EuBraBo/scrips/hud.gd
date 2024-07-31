extends CanvasLayer

onready var health_bar = $health_bar
onready var hunger_bar = $hunger_bar
onready var water_bar = $water_bar
onready var stamina_bar = $stamina_bar



export (NodePath) var player_path
onready var player = get_node(player_path)


func _process(delta):
	if player:
		health_bar.value = lerp(health_bar.value, player.health * 100 / player.max_health,0.3)
		hunger_bar.value = lerp(hunger_bar.value, player.hunger * 100 / player.max_hunger, 0.4)
		water_bar.value = lerp(water_bar.value, player.water * 100 / player.max_water, 0.4)
		stamina_bar.value = lerp(stamina_bar.value, player.stamina * 100 / player.max_stamina, 0.4)
	player.stamina_bar()	
		#print("testehub")


func re_fome () ->  void:
	print("teste fome ")
	if player.hunger >=  10:
			player.hunger = player.hunger - 10
			print("damo")
			print(player.hunger)
			emit_signal("player_stats_changer",self)	

			
				


func water_bar() -> void:
	if player.water >= 10:
		player.water = player.water - 20
		emit_signal("player_stats_changer",self)
		
			
