extends Area2D

onready var inventory_hud: CanvasLayer = $"../.."
onready var item_icon: Sprite = $"../ItemIcon"

var is_selecting : bool = false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void :
	for area in get_overlapping_areas() :
		if area.get_parent() is InventorySlotHud and not area.get_parent().slotIndex == inventory_hud.currentSlot and is_selecting == false:
			var slot : InventorySlotHud = area.get_parent()
			inventory_hud.currentSlot = slot.slotIndex
			inventory_hud.new_select_slot()
			
			if not inventory_hud.inv.slots[inventory_hud.currentSlot].item == null :
				item_icon.texture = inventory_hud.inv.slots[inventory_hud.currentSlot].item.icon
			else :
				item_icon.texture = null
			break
			
		if Input.is_action_just_pressed("Click") and area.get_parent() is InventorySlotHud and inventory_hud.slots[inventory_hud.currentSlot].slot.item :
			is_selecting = true
			item_icon.show()
			
	
	if is_selecting == true :
		item_icon.global_position = global_position
		
		if not inventory_hud.inv.slots[inventory_hud.currentSlot].item :
			is_selecting = false
			item_icon.hide()
		
		if Input.is_action_just_pressed("DROP") :
			for area in get_overlapping_areas() :
				if area.get_parent() is InventorySlotHud :
					var slotIndex : int = area.get_parent().slotIndex
					
					if not inventory_hud.inv.slots[slotIndex].item == null and not inventory_hud.inv.slots[slotIndex].item.name == inventory_hud.inv.slots[inventory_hud.currentSlot].item.name :
						continue
					
					if inventory_hud.inv.add_in_slot(slotIndex, 1, inventory_hud.inv.slots[inventory_hud.currentSlot].item) == 0 :
						inventory_hud.inv.remove_item(inventory_hud.currentSlot, 1)
					break
		
	
	if Input.is_action_just_released("Click") and is_selecting :
		is_selecting = false
		item_icon.hide()
		
		if not get_overlapping_areas() == [] :
			var slot : InventorySlotHud
			
			for area in get_overlapping_areas() :
				if area.get_parent() is InventorySlotHud  :
					slot = area.get_parent()
					break
			
			if slot == null :
				inventory_hud.inv.drop_item(inventory_hud.currentSlot, inventory_hud.player, INF)
				return
			
			if slot.slotIndex == inventory_hud.currentSlot :
				return
			
			if slot.slot.item == null or not slot.slot.item.name == inventory_hud.inv.slots[inventory_hud.currentSlot].item.name :
				inventory_hud.inv.swap_slots(inventory_hud.currentSlot, slot.slotIndex )
			else :
				var result : int = inventory_hud.inv.add_in_slot(slot.slotIndex, inventory_hud.inv.slots[inventory_hud.currentSlot].quantity )
				inventory_hud.inv.insert_item(inventory_hud.currentSlot, inventory_hud.inv.slots[inventory_hud.currentSlot].item, result)
		else :
			inventory_hud.inv.drop_item(inventory_hud.currentSlot, inventory_hud.player, INF)
	
	global_position = get_global_mouse_position()


