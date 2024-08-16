extends CanvasLayer
class_name Hud

#VARIAVES EM GERAL
onready var health_bar = $health_bar
onready var hunger_bar = $hunger_bar
onready var water_bar = $water_bar
onready var stamina_bar = $stamina_bar

var NuMoedas : int = 0
var NuOndas : int = 12


export (NodePath) var player_path
onready var player = get_node(player_path)

#FUNÇÃO EM GERAL
func _process(delta):
	barras_geral()
	moedas()
	ondas()
	

#AQUI ESTÁ TODAS AS BARRAS DA HUD	
func barras_geral() -> void:
	if player:
		health_bar.value = lerp(health_bar.value, player.health * 100 / player.max_health,0.3)
		hunger_bar.value = lerp(hunger_bar.value, player.hunger * 100 / player.max_hunger, 0.4)
		water_bar.value = lerp(water_bar.value, player.water * 100 / player.max_water, 0.4)
		stamina_bar.value = lerp(stamina_bar.value, player.stamina * 100 / player.max_stamina, 0.4)
	player.stamina_bar()	

#AQUI E A BARRA DE FOME 
func re_fome () ->  void:
#	print("teste fome ")
	if player.hunger >=  10:
			player.hunger = player.hunger - 2.3
			print("damo")
			print(player.hunger)
			emit_signal("player_stats_changer",self)	

#AQUI E A BARRA DE SEDE
func water_bar() -> void:
	if player.water >= 10:
		player.water = player.water - 2
		emit_signal("player_stats_changer",self)


func moedas () -> void:
	$AnimatedSpriteMoeda/LabelMoeda.text = str ( NuMoedas)
	
func ondas () -> void:
	$ondas.text = ("Ondas numero " + str(NuOndas))

	
