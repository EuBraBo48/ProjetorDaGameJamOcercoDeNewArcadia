extends KinematicBody2D

var move_speed : int = 64
var acceleration : float = 0.4
var friction : float = 0.2

var velocity : Vector2 = Vector2(0, 0)
onready var icon: Sprite = $Icon

var inv : Inventory = Inventory.new(12)

func _ready():
	
	inv.add_item(preload("res://Scripts/WoodBlock.tres"), 7)
	inv.add_item(preload("res://Scripts/StoneBlock.tres").duplicate(), 2)
#	inv.add_item(preload("res://Scripts/DiamondBlock.tres"), 33)
	
#	inv.remove_quantity(preload("res://Scripts/StoneBlock.tres"), 5)
#
#	print( "naooo" + str(inv.remove_item(1).quantity))
#	print(inv.insert_item(0, preload("res://Scripts/StoneBlock.tres").duplicate()))
#	inv.remove_quantity(preload("res://Scripts/StoneBlock.tres").duplicate(), 6)
	
		

func _physics_process(delta: float) -> void:
	moviment(delta, Input.get_vector("LEFT","RIGHT","UP","DOWN"))

func moviment(delta : float, moveDirection : Vector2 = Vector2.ZERO) -> void :
	var direction : Vector2 = moveDirection
	
	if direction.x > 0 :
		icon.scale.x = 1
	elif direction.x < 0 :
		icon.scale.x = -1
	
	
	if direction == Vector2.ZERO :
		velocity = lerp(velocity, Vector2.ZERO, friction)
	else:
		velocity = lerp(velocity, direction * move_speed, friction)
	
	move_and_slide(velocity)
	
