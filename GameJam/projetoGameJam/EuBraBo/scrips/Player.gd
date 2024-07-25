extends KinematicBody2D
 #variaves da animação do player e Strite
onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite__player:Sprite = get_node("Sprite_Player")

#variaves da movintação do player top dawn
var playe : Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)
export(int) var speed


func _process(delta):
	mov_play() # aqui e a movinentsção do player top dawn


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
	if velocity != Vector2.ZERO:
		animation.play("run")
	else:
		animation.play("Idle")	
		

func verify_direction() -> void:
	if velocity.x > 0:
		sprite__player.flip_h = false
	elif velocity.x < 0:
		sprite__player.flip_h = true			 	
			
#falta o dash para fimaniza a movintação total do nosso pleyer
