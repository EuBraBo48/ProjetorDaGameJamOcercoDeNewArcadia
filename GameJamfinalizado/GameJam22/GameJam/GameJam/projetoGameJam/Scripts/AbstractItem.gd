
extends Area2D
class_name AbstractItem

onready var icon: Sprite = $Icon
onready var pick_timer: Timer = $PickTimer
var absIcon := preload("res://Cenas/AbstractIcon.tscn")

export var item : Resource
var can_picked : bool = false

var target : Node2D
var drop_pos : Vector2
var drop_move : bool = true 

func _ready() -> void:
	set_process(false)
	icon.texture = item.icon 
	icon.scale = Vector2.ONE / (icon.texture.get_size() / 16) * 0.8
	
	
	print(drop_pos)
	yield (get_tree().create_timer(0.2), "timeout")
	
	drop_pos = Vector2(rand_range(-5,5), rand_range(-5,5)) + global_position
	
	set_process(true)

func _process(delta: float) -> void:
	global_position = lerp(global_position, drop_pos, 0.1)
	
	if pick_timer and pick_timer.is_stopped() == true and is_in_catch() == false :
		pick_timer.start()

func pick(_target) -> Resource :
	can_picked = false
	target = _target
	
	var iconInstance := absIcon.instance()
	iconInstance.global_position = global_position
	iconInstance.texture = item.icon
	iconInstance.target = target
	get_parent().add_child(iconInstance)
	
	
	queue_free()
	return item

func is_in_catch() -> bool :
	for i in get_overlapping_areas() :
		if i.name == "CatchArea" :
			return true
	return false

func _on_PickTimer_timeout() -> void:
	can_picked = true
