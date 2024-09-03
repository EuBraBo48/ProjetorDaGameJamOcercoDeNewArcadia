extends Node
class_name Hotbar 

var itemController : ItemController
onready var inv : Inventory 
var hotbarSize : int = 6

var currentSlot : int = 0
var currentItem : Item 

var player : Node2D

func start(_player : Node2D) -> void :
	player = _player
	inv = _player.inv
	
	inv.connect("atualized", self, "atualize_hotbar")
	
	atualize_hotbar()

func _process(delta: float) -> void :
	if itemController :
		if itemController.item == null and not currentItem == null or itemController.item and not itemController.item.item == currentItem :
			itemController.atualize_item(currentItem)

func physics_process(delta):
	if itemController :
		itemController.physics_process(delta)

func process(delta):
	if itemController :
		itemController.process(delta)
	
	if Input.is_action_just_pressed("DROP") :
		inv.drop_item(currentSlot, player)
	
	if itemController :
		if itemController.item == null and not currentItem == null or itemController.item and not itemController.item.item == currentItem :
			itemController.atualize_item(currentItem)

func input(event):
	slot_control(event)

func atualize_hotbar(slot : int = currentSlot) -> void :
	currentSlot = slot
	currentItem = inv.slots[currentSlot].item

func slot_control(event) :
	if itemController.canSwap == false :
		return
	
	if event is InputEventKey and event.is_pressed() :
		if event.scancode >= KEY_1 and event.scancode <= KEY_0 + hotbarSize :
			atualize_hotbar(event.scancode - KEY_0 - 1)
