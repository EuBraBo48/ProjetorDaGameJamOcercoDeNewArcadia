extends CanvasLayer
class_name Hud

# VARIÁVEIS EM GERAL
onready var health_bar = $health_bar
onready var hunger_bar = $hunger_bar
onready var water_bar = $water_bar
onready var stamina_bar = $stamina_bar

var NuMoedas : int = 0
var NuOndas : int = 0
var tempo = 20.0
signal tamo 


export (NodePath) var player_path
onready var player = get_node(player_path)


export (NodePath) var ZUMBIS_path
onready var zumbis = get_node(ZUMBIS_path)

onready var timer: Timer = $tempo/Timer
onready var hud_controller: CanvasLayer = $"../HudController"
onready var tween: Tween = $Tween

func _ready():
	$tempo.text = str(tempo)
	player.connect("dead", self, "game_over")


# FUNÇÃO EM GERAL
func _process(delta):
	barras_geral()
	moedas()
	ondas()

# AQUI ESTÃO TODAS AS BARRAS DA HUD	
func barras_geral() -> void:
	if player:
		health_bar.value = lerp(health_bar.value, player.health * 100 / player.max_health, 0.3)
		hunger_bar.value = lerp(hunger_bar.value, player.hunger * 100 / player.max_hunger, 0.4)
		water_bar.value = lerp(water_bar.value, player.water * 100 / player.max_water, 0.4)
		stamina_bar.value = lerp(stamina_bar.value, player.stamina * 100 / player.max_stamina, 0.4)
	player.stamina_bar()	


# AQUI É A BARRA DE FOME 
func re_fome() -> void:
	if hud_controller.activeHud.name.to_lower() == "shophud" :
		return
	if player.hunger >= 0:
		player.hunger -= 1.5
		print("dano")
		print(player.hunger)
		player.emit_signal("player_stats_changer", self)
	if player.hunger <= 0 :
		player.damo(5)

# AQUI É A BARRA DE SEDE
func water_bar() -> void:
	if hud_controller.activeHud.name.to_lower() == "shophud" :
		return
	
	if player.water > 0:
		player.water -= 1
		player.emit_signal("player_stats_changer", self)
	if player.water <= 0 :
		player.damo(5)


func moedas() -> void:
	$AnimatedSpriteMoeda/LabelMoeda.text = str(NuMoedas)

	
func ondas() -> void:
	$ondas.text = "Onda de numero " + str(NuOndas)


func _on_Timer_timeout():
	if zumbis.get_children() == [] :
		timer.stop()
		hud_controller.transite_hud("ShopHud")
		return
	
	tempo -= 1
	print(tempo)
	$tempo.text = str(tempo)
	if tempo == 0:
		for zumbins in zumbis.get_children():
			zumbins.queue_free()
		timer.stop()
		hud_controller.transite_hud("ShopHud")
		$"../../sounds".stop()

func waves_restart() :
	hud_controller.transite_hud("HotbarHud")
	NuOndas += 1
	tempo = 30
	$tempo.text = str(tempo)
	timer.start()
	
	player.health = 100
	player.stamina = 70
	emit_signal("tamo")

   
	
	
func game_over() :
	hud_controller.transite_hud("HotbarHud")
	$CanvasLayer.layer = 3
	var transi = tween.create_tween()
	transi.tween_property($CanvasLayer/Panel, "modulate", Color(255), 2)
	timer.stop()
	
	yield(transi, "finished")
	get_tree().change_scene("res://EuBraBo/scenes/telaDeTilulo.tscn")
	
