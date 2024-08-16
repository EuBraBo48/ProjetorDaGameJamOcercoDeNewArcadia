extends KinematicBody2D
class_name zumbiTank


var velocity: Vector2 = Vector2(0,0) 
var _player_ref: Player = null
var speed : int = 30
var distancia : float = 0.0
var attack_delay: float = 1.0  # Tempo de atraso entre ataques (em segundos)
var time_since_last_attack: float = 0.0  # Tempo desde o último ataque


export(NodePath) var textura_path : NodePath
export(NodePath) var animTank_path : NodePath


var textura : Sprite
var animTank : AnimationPlayer


export(NodePath) var player_path
onready var player = get_node(player_path)


func _ready() -> void:
	_player_ref = player
	if textura_path:
		textura = get_node(textura_path) as Sprite
	if animTank_path:
		animTank = get_node(animTank_path) as AnimationPlayer


func _on_deterquito_body_entered(_body):
	if _body.is_in_group("Player"):
		_player_ref = _body

	
func _on_deterquito_body_exited(_body):
	if _body.is_in_group("Player"):
		_player_ref = null
		velocity = Vector2(0, 0)


func _physics_process(_delta: float) -> void:
	time_since_last_attack += _delta  # Atualiza o tempo desde o último ataque
	animent()
	verivicaPS()
	
	
	if _player_ref != null:
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distansia : float = global_position.distance_to(_player_ref.global_position)
		distancia = _distansia
		
		move_and_slide(_direction * speed)
		velocity = _direction
	
	
func verivicaPS() -> void:
	if velocity.x > 0:
		textura.flip_h = false
		
	elif velocity.x < 0:
		textura.flip_h = true	


func animent() -> void:
	if distancia < 18 and time_since_last_attack >= attack_delay :
		animTank.play("Atack")
		if animTank.current_animation_position >= 0.5:
			print("teste DAMo 2")
			player.damo()
			time_since_last_attack = 0.0  
			# _player_ref.damo()
			
		return
		
	elif velocity != Vector2.ZERO:
		animTank.play("run")
		return
	
	else:
		animTank.play("ide")
	
