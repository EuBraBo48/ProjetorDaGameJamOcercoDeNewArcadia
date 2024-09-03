extends Node2D
class_name ItemBase

var player : Player
onready var icon : Sprite = $Icon
var item : Item

func start(_item) -> void:
	item = _item
	icon.texture = item.icon

func enter() -> void :
	pass

func exit() -> void :
	print(4543546)

func process(delta : float) -> void :
	pass

func physics_process(delta : float) -> void :
	pass
