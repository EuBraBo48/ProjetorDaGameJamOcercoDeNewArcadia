extends HudBase
class_name InventoryHud

onready var mouse_controller: Area2D = $Control/MouseController
onready var inventory_container: GridContainer = $Control/InventoryContainer
onready var select_slot_sprite: AnimatedSprite = $Control/SelectSlotSprite
onready var animations: AnimationPlayer = $Animations

var slots : Array = []
var inv : Inventory 

var currentSlot : int = 0

func start() -> void :
	inv = player.inv
	inv.connect("atualized", self, "atualize_slots")
	
	for i in inventory_container.get_child_count() :
		var child := inventory_container.get_child(i)
		
		slots.append(child)
		child.start(inv.slots[i], i)

func process(delta: float) -> void:
	select_slot_sprite.global_position = slots[currentSlot].rect_global_position + Vector2(16,16) * slots[currentSlot].rect_scale
	
	if Input.is_action_just_pressed("DROP") and mouse_controller.is_selecting == false :
		inv.drop_item(currentSlot, player, 1)

func new_select_slot() -> void :
	if slots[currentSlot].get_node("Animations").is_playing() :
		slots[currentSlot].get_node("Animations").stop()
	slots[currentSlot].get_node("Animations").play("Selected")
	
	if select_slot_sprite.get_node("Animations").is_playing() :
		select_slot_sprite.get_node("Animations").stop()
	select_slot_sprite.get_node("Animations").play("Selected")

func atualize_slots() -> void :
	for slot in slots.size() :
		slots[slot].atualize_slot()

func open() -> void :
	currentSlot = 0
	animations.play("Open")
	mouse_controller.set_physics_process(true)

func close() -> void :
	animations.play("Close")
	mouse_controller.set_physics_process(false)
	mouse_controller.is_selecting = false
	mouse_controller.item_icon.hide()

