extends KinematicBody2D
 #variaves da animação do player e Strite
onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite__player:Sprite = get_node("Sprite_Player")


#varives para barras em geral
var health := 100.0
var max_health := 100.0
var health_recovery :=3.5

var hunger := 100.0
var max_hunger := 100.0
var hunger_recorvey := 3.5

var water := 100.0
var max_water := 100.0
var water_recorvery := 3.5

var stamina := 100.0
var max_stamina := 100.0
var stamina_recorvey := 1.0

#sinal para barra 
signal player_stats_changer 



#variaves da movintação do player top dawn
var playe : Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)
export(int) var speed


func _ready():
	pass
	

func _process(delta):
	mov_play() # aqui e a movinentsção do player top dawn
	emit_signal("player_stats_changer")

	
	
	var new_health = min(health + health_recovery * delta, max_health) 
	if new_health != health and hunger == 100 and water == 100:
		print('to com fome')
		health = new_health
		emit_signal("player_stats_changer",self)
		#print("testevida")
	var new_stamina = min(stamina +  stamina_recorvey * delta, max_stamina)
	if new_stamina != stamina:
		print("teste")
		stamina = new_stamina
		emit_signal("player_stats_changer")
	
	
func _physics_process(_delta:float) ->void:
	animete() #Aqui e  função da minha animação
	verify_direction() #Aqui e para espelha o personages 
	
func mov_play() -> void:
	if Input.is_action_pressed("mv_direito"):
		playe.x = 1
		
	elif Input.is_action_pressed("mv_esquerda"):
		playe.x = -1
	elif Input.is_action_pressed("mv_cima"):
		playe.y = -1	
	elif Input.is_action_pressed("mv_baixo"):
		playe.y = 1
	else:
		playe.x = 0
		playe.y = 0
		
	velocity = playe.normalized()* speed
	move_and_slide(velocity)	
		

func animete() -> void:
	if velocity != Vector2.ZERO :
		animation.play("run")
		$PassosPlayer.play() #aqui é son de passo do player
		
	else:
		animation.play("Idle")
		$PassosPlayer.stop() #aqui é son do passo do player
		

func verify_direction() -> void:
	if velocity.x > 0:
		sprite__player.flip_h = false
	elif velocity.x < 0:
		sprite__player.flip_h = true			 	
			
#falta o dash para fimaniza a movintação total do nosso pleyer



		
 #func damo() -> void:
	#if Input.is_action_pressed("mv_baixo"):	 SOR EDITA AQUI QUANDO TIVER IMINIGOS 
		#	if health >=  10:
		#		health = health - 10
		#		print("damo")
		#		print(health)
		#		emit_signal("player_stats_changer",self)
		
# isso e temporaio 
func _unhandled_input(event):
	if event.is_action_pressed("mv_baixo"):	
		if health >=  10:
				health = health - 10
				print("damo")
				print(health)
				emit_signal("player_stats_changer",self)		
func stamina_bar() -> void:
	if Input.is_action_just_pressed("mv_dash") and stamina > 2: 
		speed = 300
		stamina -= 15
		animation.play("roll")
	elif Input.is_action_just_released("mv_dash"):
		speed = 60
		
	
