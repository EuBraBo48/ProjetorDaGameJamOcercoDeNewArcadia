extends ItemBase
class_name FireWeaponBase

onready var animations: AnimationPlayer = $Animations
onready var cooldown_timer: Timer = $CooldownTimer
onready var bullet_pos: Node2D = $BulletPos
onready var audio_stream_player = $AudioStreamPlayer


export var bullet : PackedScene = preload("res://Cenas/BulletBase.tscn")
var canFire : float = false
export var espin : bool = false


func _ready():
	audio_stream_player.stream.loop = false

func process(delta : float) -> void : 
	if canFire and Input.is_action_pressed("Click") :
		shoot()

func shoot() -> void :
	animations.play("FIRE")
	canFire = false
	cooldown_timer.start(item.cooldown)
	audio_stream_player.play()
	
	var balaI : Bullet = bullet.instance()
	balaI.global_position = bullet_pos.global_position
	balaI.direction = global_position.direction_to(bullet_pos.global_position)
	balaI.damage = item.damage
	get_tree().root.get_child(0).get_node("Bullets").add_child(balaI)
	
	if espin == true :
		var balaI1 : Bullet = bullet.instance()
		balaI1.global_position = bullet_pos.global_position
		balaI1.direction = global_position.direction_to(bullet_pos.global_position)
		balaI1.damage = item.damage
		balaI1.velocity /= 1.5
		get_tree().root.get_child(0).get_node("Bullets").add_child(balaI1)
		
		var balaI2 : Bullet = bullet.instance()
		balaI2.global_position = bullet_pos.global_position
		balaI2.direction = global_position.direction_to(bullet_pos.global_position)
		balaI2.damage = item.damage
		get_tree().root.get_child(0).get_node("Bullets").add_child(balaI2)
		balaI2.velocity /= 2

func _on_CooldownTimer_timeout() -> void:
	canFire = true

func enter() :
	cooldown_timer.start(item.cooldownRemaining)

func exit() :
	item.cooldownRemaining = clamp(cooldown_timer.time_left,0, INF)
