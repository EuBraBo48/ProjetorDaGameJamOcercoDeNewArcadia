extends Node
class_name Inventory

signal atualized

class InventorySlot :
	var item : Item
	var quantity : int
	
	func _init(_item : Item, _quantity : int):
		item = _item
		quantity = _quantity

var slots : Array = []
var maxSlots : int 

var abstractItem : PackedScene = preload("res://Cenas/AbstractItem.tscn")

func _init(max_slots : int = 8) -> void :
	maxSlots = max_slots
	
	for i in range(maxSlots) :
		slots.append(InventorySlot.new(null, 0))

func add_item(item : Item, quantity : int = 1) -> Array :
	var remainingItems : Array = []
	
	for slot in slots :
		if slot.item == null :
			continue
		
		if slot.item.name == item.name :
			if slot.quantity < slot.item.maxQuantity :
				var result : int = slot.quantity + quantity
				
				if result <= slot.item.maxQuantity :
					slot.quantity += quantity
					quantity = 0
					break
				else :
					slot.quantity = slot.item.maxQuantity
					quantity = result - item.maxQuantity
	
	for slot in slots :
		if slot.item == null and quantity > 0:
			slot.item = item
			
			var result : int = slot.quantity + quantity
			
			if result <= slot.item.maxQuantity :
				slot.quantity = result
				quantity -= quantity
				break
			else :
				slot.quantity = slot.item.maxQuantity
				quantity = result - item.maxQuantity
	
	while quantity > 0 :
		if quantity <= item.maxQuantity :
			remainingItems.append(InventorySlot.new(item, quantity))
			break
		else :
			remainingItems.append(InventorySlot.new(item, item.maxQuantity))
			quantity -= item.maxQuantity
		
	emit_signal("atualized")
	return remainingItems

func add_in_slot(slot : int, quantity : int = 1, item : Item = null) -> int :
	if slot >= slots.size() :
		return quantity
	
	if slots[slot].item == null :
		if not item :
			return quantity
		
		slots[slot].item = item
		slots[slot].quantity = clamp(quantity, 0, slots[slot].item.maxQuantity)
		
		emit_signal("atualized")
		return 0 if quantity < slots[slot].item.maxQuantity else quantity - slots[slot].item.maxQuantity
	
	var result = slots[slot].quantity + quantity
	
	if result > slots[slot].item.maxQuantity :
		slots[slot].quantity = slots[slot].item.maxQuantity
		emit_signal("atualized")
		return result - slots[slot].item.maxQuantity
	else :
		slots[slot].quantity = result
		emit_signal("atualized")
		return 0

func remove_item(slot : int, quantity : int) -> InventorySlot :
	
	if slot >= slots.size() :
		return null
	
	if slots[slot].item == null :
		return null
	else :
		var item : InventorySlot 
		
		var result = slots[slot].quantity - quantity
		
		if result > 0 :
			slots[slot].quantity = result
			item = InventorySlot.new(slots[slot].item, slots[slot].quantity)
		else :
			slots[slot].item = null
			slots[slot].quantity = 0
			item = null
		
		
		emit_signal("atualized")
		return item

func remove_quantity(item : Item, quantity : int) -> Array :
	var removedItems : Array = []
	var removeQuantity : int = quantity
	
	for slot in slots :
		
		if slot.item == null :
			continue
		
		if slot.item.name == item.name :
			var remainingItems = slot.quantity - removeQuantity
			
			if remainingItems >= 0 :
				slot.quantity = remainingItems
				
				if slot.quantity == 0 :
					if removeQuantity > 0 :
						removedItems.append(InventorySlot.new(slot.item, slot.quantity))
					
					slot.item = null
					break
				
				if removeQuantity > 0 :
					removedItems.append(InventorySlot.new(slot.item, removeQuantity))
				break
			
			else :
				removeQuantity = abs(remainingItems)
				
				removedItems.append(InventorySlot.new(slot.item, slot.quantity))
				
				slot.item = null
				slot.quantity = 0
	
	emit_signal("atualized")
	return removedItems

func insert_item(slot : int, item : Item, quantity : int = 1) -> InventorySlot :
	if slot >= slots.size() :
		var newSlot : InventorySlot = InventorySlot.new(item, quantity)
		
		return newSlot
	
	if quantity < 1 :
		slots[slot].item = null
		slots[slot].quantity = 0
		
		emit_signal("atualized")
		return null
	
	if slots[slot].item == null :
		slots[slot].item = item 
		
		if item :
			slots[slot].quantity = clamp(quantity, 0, slots[slot].item.maxQuantity)
		else :
			slots[slot].quantity = 0
			
		emit_signal("atualized")
		return null
	
	else :
		var oldItem : InventorySlot = InventorySlot.new(slots[slot].item, slots[slot].quantity)
		slots[slot].item = item
		
		if item :
			slots[slot].quantity = clamp(quantity, 0, slots[slot].item.maxQuantity)
		else :
			slots[slot].quantity = 0
		
		emit_signal("atualized")
		
		return oldItem

func drop_item(slot : int, user : Node2D, quantity : int = 1) -> Item :
	if slot > slots.size() - 1 :
		return null
	
	if slots[slot] == null : 
		return null
	
	var item : Item = slots[slot].item
	
	if slots[slot].quantity - quantity < 0 :
		quantity = slots[slot].quantity
	
	while quantity > 0 :
		var itemInstance : AbstractItem = abstractItem.instance()
		itemInstance.item = slots[slot].item
		user.get_parent().call("add_child", itemInstance)
		itemInstance.global_position = user.global_position
		user.get_parent().move_child(itemInstance, 0) 
		
		
		slots[slot].quantity -= 1
		quantity -= 1
	
	if slots[slot].quantity == 0 :
		slots[slot].item = null
	
	emit_signal("atualized")
	return item

func swap_slots(slot1 : int, slot2 : int) -> void :
	
	for slot in [slot1, slot2] :
		if slot >= slots.size() :
			return
	
	var oldSlot1 : InventorySlot = InventorySlot.new(slots[slot1].item, slots[slot1].quantity)
	
	insert_item(slot1, slots[slot2].item, slots[slot2].quantity) 
	insert_item(slot2, oldSlot1.item, oldSlot1.quantity) 
	emit_signal("atualized")
	
