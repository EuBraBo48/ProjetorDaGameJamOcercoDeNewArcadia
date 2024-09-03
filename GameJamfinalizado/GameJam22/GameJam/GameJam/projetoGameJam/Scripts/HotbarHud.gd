extends HudBase
class_name HotbarHud
onready var hotbar = $Hotbar

var slots : Array = []
var currentSlot : int
onready var slot_container: GridContainer = $HotbarHud/SlotContainer
onready var select_slot_sprite: AnimatedSprite = $HotbarHud/SelectSlotSprite

func start() -> void :
	for i in slot_container.get_child_count():
		slots.append(slot_container.get_child(i))
		slot_container.get_child(i).start(player.inv.slots[i])
	
	player.inv.connect("atualized", self, "atualize_hotbar_slots")
	select_slot_sprite.global_position = slots[0].rect_global_position
	currentSlot = hotbar.currentSlot
	select_slot_sprite.global_position = slots[hotbar.currentSlot].rect_global_position + (slots[currentSlot].rect_size * 1.3) * slots[currentSlot].rect_scale /2
	
	hotbar.itemController = get_parent().get_node(get_parent().itemControllerPath)
	get_parent().get_node(get_parent().itemControllerPath).hotbar = hotbar
	hotbar.start(player)


func process(delta: float) -> void:
	hotbar.process(delta)
	if not slots : 
		return
	
	select_slot_sprite.global_position = slots[hotbar.currentSlot].rect_global_position + (slots[currentSlot].rect_size * 1.3) * slots[currentSlot].rect_scale /2
	
	if not currentSlot == hotbar.currentSlot :
		currentSlot = hotbar.currentSlot
		
		if slots[currentSlot].get_node("Animations").is_playing():
				slots[currentSlot].get_node("Animations").stop()
		
		if select_slot_sprite.get_node("Animations").is_playing():
			select_slot_sprite.get_node("Animations").stop()
		
		slots[currentSlot].get_node("Animations").play("Selected")
		select_slot_sprite.get_node("Animations").play("Selected")

func physics_process(delta : float) -> void :
	hotbar.physics_process(delta)

func input(event: InputEvent) -> void :
	hotbar.input(event)

func atualize_hotbar_slots() -> void :
	for slot in slots :
		slot.atualize_slot()

func open() -> void :
	pass

func close() -> void :
	pass
