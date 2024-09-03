extends KinematicBody2D
class_name zumbiExplosion


var velocity: Vector2 = Vector2(0,0) 
var _player_ref: Player = null
var speed : int = 50
var dano : int = 30
var vida : = 50

var attack_delay: float = 1.0  # Tempo de atraso entre ataques (em segundos)
var time_since_last_attack: float = 0.0  # Tempo desde o último ataque

export(NodePath) var textura_path : NodePath
export(NodePath) var animExplosion_paht : NodePath


var textura : Sprite
var animExplo : AnimationPlayer
var coin = preload("res://EuBraBo/scenes/Moeda.tscn")

func _ready() -> void:	
	_player_ref = _player_ref
	if textura_path:
		textura = get_node(textura_path) as Sprite
	if animExplosion_paht:
		animExplo = get_node(animExplosion_paht) as AnimationPlayer
	

func _on_deterquito_body_entered(_body):
	if _body.is_in_group("Player"):
		_player_ref = _body
	
	
func _on_deterquito_body_exited(_body):
	if _body.is_in_group("Player")  :
		_player_ref = null
		velocity = Vector2(0, 0)


func _physics_process(_delta: float) -> void:
	time_since_last_attack += _delta  # Atualiza o tempo desde o último ataque
	animent()
	verivicaPS()
	
	
	if _player_ref != null:
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		
		move_and_slide(_direction * speed)
		velocity = _direction

func dano(damage : int) :
	vida -= damage
	$HitFlash.play("Hit")
	
	if vida <= 0 :
		var moeda = coin.instance()
		moeda.global_position = global_position
		get_tree().root.get_child(0).call_deferred("add_child", moeda)
		
		queue_free()

func animent() -> void:
	if velocity != Vector2.ZERO:
		animExplo.play("run")
		$PassosZumbi.play()
		return
	else:
		animExplo.play("idle")
		$PassosZumbi.stop()

func verivicaPS() -> void:
	if velocity.x > 0:
		textura.flip_h = false
		
	elif velocity.x < 0:
		textura.flip_h = true	
		

func _on_atack_body_entered(_body):
	if _body.is_in_group("Player") and _body.imortal == false:
		animExplo.play("explosion")
		print("teste de animação de damo")
		  # Reseta o tempo desde o último ataque
		if animExplo.current_animation == "explosion":
			$Explosivo.play()
			_player_ref.damo(dano)
			queue_free()
			
