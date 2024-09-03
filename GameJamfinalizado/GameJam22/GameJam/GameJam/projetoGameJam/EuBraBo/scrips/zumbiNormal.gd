extends KinematicBody2D
class_name ZumbiNormal

# Variáveis e propriedades
var velocity: Vector2 = Vector2(0, 0)
var _player_ref: Player = null
var speed = 40
var distancia = 0.0
var attack_delay: float = 1.0  # Tempo de atraso entre ataques (em segundos)
var time_since_last_attack: float = 0.0  # Tempo desde o último ataque
var vida : int = 100
var dano : int = 15

export (NodePath) var textura_path: NodePath
export (NodePath) var animZumbiN_path: NodePath
#export (NodePath) var player_path: NodePath

var textura: Sprite
var animZumbiN: AnimationPlayer
var coin = preload("res://EuBraBo/scenes/Moeda.tscn")
#onready var player = get_node(player_path)


func _ready() -> void:
	_player_ref = _player_ref
	if textura_path:
		textura = get_node(textura_path) as Sprite
	if animZumbiN_path:
		animZumbiN = get_node(animZumbiN_path) as AnimationPlayer


func _on_deterquito_body_entered(_body) -> void:
	if _body.is_in_group("Player"):
		_player_ref = _body as Player


func _on_deterquito_body_exited(_body) -> void:
	if _body.is_in_group("Player"):
		_player_ref = null
		velocity = Vector2(0, 0)

func dano(damage : int) :
	vida -= damage
	$HitFlash.play("Hit")
	
	if vida <= 0 :
		var moeda = coin.instance()
		moeda.global_position = global_position
		get_tree().root.get_child(0).call_deferred("add_child", moeda)
		
		queue_free()

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
	if distancia < 50 and time_since_last_attack >= attack_delay and _player_ref  :  # Ajuste a distância conforme necessário
		animZumbiN.play("atack")
		if animZumbiN.current_animation_position >= 0.5:
			_player_ref.damo(dano)
			print("testeDAMO")
			time_since_last_attack = 0.0  # Reseta o tempo desde o último ataque
		return
	elif velocity != Vector2.ZERO:
		animZumbiN.play("run")
		$PassosZumbi.play()
		return
	else:
		animZumbiN.play("ide")
		$PassosZumbi.stop()

func verivicaPS() -> void:
	if velocity.x > 0:
		textura.flip_h = false
	elif velocity.x < 0:
		textura.flip_h = true
