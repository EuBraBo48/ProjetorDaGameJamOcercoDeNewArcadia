extends KinematicBody2D
class_name ZumbiFogo


# Variáveis e propriedades
var velocity: Vector2 = Vector2(0, 0)
var _player_ref: Player = null
var speed = 40
var distancia = 0.0
var attack_delay: float = 1.0  # Tempo de atraso entre ataques (em segundos)
var time_since_last_attack: float = 0.0  # Tempo desde o último ataque


export (NodePath) var textura_path: NodePath
export (NodePath) var animZumbiFogo_path: NodePath


var textura: Sprite
var animZumbiFogo: AnimationPlayer



func _ready() -> void:
	_player_ref = _player_ref
	if textura_path:
		textura = get_node(textura_path) as Sprite
	if animZumbiFogo_path:
		animZumbiFogo = get_node(animZumbiFogo_path) as AnimationPlayer


func _on_detequito_body_entered(_body):
	if _body.is_in_group("Player"):
		_player_ref = _body as Player


func _on_detequito_body_exited(_body):
	if _body.is_in_group("Player"):
		_player_ref = null
		velocity = Vector2(0, 0)


func _physics_process(_delta: float) -> void:
	time_since_last_attack += _delta  # Atualiza o tempo desde o último ataque
	animent()
	verivicaPS()
	if _player_ref != null:
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distansia: float = global_position.distance_to(_player_ref.global_position)
		distancia = _distansia
		move_and_slide(_direction * speed)
		velocity = _direction


func animent() -> void:
	if distancia < 50 and time_since_last_attack >= attack_delay and _player_ref :  # Ajuste a distância conforme necessário
		animZumbiFogo.play("atack")
		if animZumbiFogo.current_animation_position >= 0.5:
			_player_ref.damo()
			print("testeDAMO")
			time_since_last_attack = 0.0  # Reseta o tempo desde o último ataque
		return
	elif velocity != Vector2.ZERO:
		animZumbiFogo.play("run")
		return
	else:
		animZumbiFogo.play("idle")


func verivicaPS() -> void:
	if velocity.x > 0:
		textura.flip_h = false
	elif velocity.x < 0:
		textura.flip_h = true

