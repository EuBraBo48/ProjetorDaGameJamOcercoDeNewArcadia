extends KinematicBody2D
class_name Player

# Variáveis em geral
onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite__player: Sprite = get_node("Sprite_Player")

# Variáveis para barras em geral
var health := 100
var max_health := 100.0
var health_recovery := 3.5

var hunger := 100.0
var max_hunger := 100.0
var hunger_recorvey := 3.5

var water := 100.0
var max_water := 100.0
var water_recorvery := 3.5

var stamina := 100.0
var max_stamina := 100.0
var stamina_recorvey := 1.0

# Sinal para barra
signal player_stats_changer
signal dead

# Variáveis de movimentação do player
var playe: Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)
export(int) var speed = 128

var inv : Inventory = Inventory.new(12)
var canMove = true
var death = false
var dashing = false
var imortal = false

func _ready():
	# Inicialização
#	inv.add_item(preload("res://Scripts/StoneBlock.tres"), 3)
	pass

func _process(delta):
	if canMove and dashing == false and death == false:
		mov_play()  # Movimentação do player
	elif dashing == false :
		playe = Vector2.ZERO
		velocity = Vector2.ZERO
	emit_signal("player_stats_changer")
	
	if death == true :
		return
	
	if Input.is_action_just_pressed("mv_dash") and stamina >= 25 and dashing == false and not playe == Vector2.ZERO :
		stamina -= 25
		water -= 5
		animation.play("roll")
		dashing = true
		imortal = true
		dash_move()
	
	if dashing == true :
		dash_move()
	
	# Regeneração da vida e da stamina
	var new_health = min(health + health_recovery * delta, max_health)
	if new_health != health and hunger == 100 and water == 100:
		health = new_health
		emit_signal("player_stats_changer", self)
	var new_stamina = min(stamina + stamina_recorvey * delta, max_stamina)
	if new_stamina != stamina:
		stamina = new_stamina
		emit_signal("player_stats_changer")


func _physics_process(_delta: float) -> void:
	move_and_slide(velocity)
	
	if death == true or dashing == true :
		return
	animete()  # Animação do player
	verify_direction()  # Verifica a direção do player


func mov_play() -> void:
	playe = Input.get_vector("mv_esquerda", "mv_direito", "mv_cima", "mv_baixo")
	
	velocity = lerp(velocity, playe.normalized() * speed, 0.2)


func animete() -> void:
	if playe != Vector2.ZERO:
		animation.play("run")
		$PassosPlayer.play()  # Som de passos
	else:
		animation.play("Idle")
		$PassosPlayer.stop()  # Para o som dos passos


func verify_direction() -> void:
	if velocity.x > 0:
		sprite__player.flip_h = false
	elif velocity.x < 0:
		sprite__player.flip_h = true

func dash_move() :
	velocity = playe.normalized() * 256
	
	if animation.is_playing() == false :
		dashing = false
		imortal = false
		playe = Vector2.ZERO
		velocity = Vector2.ZERO

func death() :
	death = true
	dashing = false
	if not animation.current_animation == "dead" :
		animation.play("dead")
	emit_signal("dead")

func damo(damage : int) -> void:
	if death == true or imortal == true :
		return
	if health >= 0 :
		health -= damage
		$HitFlash.play("Hit")
		emit_signal("player_stats_changer", self)
	
	if health <= 0 :
		death()

func stamina_bar() -> void:
	pass

