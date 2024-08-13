extends KinematicBody2D
class_name ZumbiNormal
 

var velocity:Vector2 = Vector2(0, 0)
var _player_ref : Player = null
var speed = 35
var distancia = 0.0


export (NodePath) var textura_path: NodePath
export (NodePath) var animZumbiN_path: NodePath


var textura: Sprite
var animZumbiN: AnimationPlayer


export (NodePath) var player_path
onready var player = get_node(player_path)


func _ready() -> void:
	if textura_path:
		textura = get_node(textura_path) as Sprite
	if animZumbiN_path:
		animZumbiN = get_node(animZumbiN_path) as AnimationPlayer
	

func _on_deterquito_body_entered(_body) -> void:
	if _body.is_in_group("Player"):
		_player_ref = _body


func _on_deterquito_body_exited(_body) -> void:
	if _body.is_in_group("Player"):
		_player_ref = null
		velocity = Vector2(0, 0)


func _physics_process(_delta: float) -> void:
	animent()
	verivicaPS()
	if _player_ref != null:	
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distansia : float = global_position.distance_to(_player_ref.global_position)
		distancia = _distansia
		# Aplique a velocidade ao movimento do Zumbi
		move_and_slide(_direction * speed)
		velocity = _direction
	
	
	
	
				
	
	#if Input.is_action_just_pressed("mv_direito") : 
	#	queue_free()

func animent() -> void:
	if distancia < 20 :
		 animZumbiN.play("atack")
		 if animZumbiN.current_animation_position >= 0.5:
		  _player_ref.damo()
		  print("testeDAMO")	
		
		
		 return 
	
	elif velocity != Vector2.ZERO:
		 animZumbiN.play("run")
		 return 


	else:	
		animZumbiN.play("ide")
		#print("testeIDLE")

func verivicaPS() -> void:
	if velocity.x > 0:
		textura.flip_h = false
		
	elif velocity.x < 0:
		textura.flip_h = true



