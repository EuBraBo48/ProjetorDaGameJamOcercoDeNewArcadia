extends Node2D
class_name ItemController

onready var item : ItemBase 
var hotbar 
var canSwap = true

func atualize_item(_item : Item) :
	print(_item)
	
	var oldAngle = 0
	var oldPosition = Vector2.ZERO
	
	if item :
		oldAngle = item.rotation
		oldPosition = item.position
		
		item.exit()
		item.call_deferred("queue_free")
		item = null
	
	if _item :
		item = _item.scene.instance()
		add_child(item)
		
		item.player = get_parent()
		item.position = oldPosition
		item.rotation = oldAngle
		item.call("start", _item)
		item.enter()

func process(delta : float) -> void :
	if item :
		item.process(delta)

func physics_process(delta: float) -> void :
	if item :
		item_moviment(delta)
		item.physics_process(delta)

func item_moviment(delta : float) -> void :
	item.position = lerp(item.position, global_position.direction_to(get_global_mouse_position()) * clamp(global_position.distance_to(get_global_mouse_position()), -item.item.maxDistance, item.item.maxDistance), 0.5)
	item.rotation_degrees = rad2deg(lerp_angle(item.rotation, global_position.direction_to(get_global_mouse_position()).angle(), 0.5))
	item.icon.flip_v = item.position.x < 0
