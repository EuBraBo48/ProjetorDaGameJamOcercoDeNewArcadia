extends TextureRect
class_name a

var slot : Inventory.InventorySlot

onready var item_icon: Sprite = $ItemIcon
onready var item_quantity: Label = $ItemQuantity

func start(_slot) -> void :
	slot = _slot
	atualize_slot()

func atualize_slot() -> void :
	if slot.item == null :
		item_icon.texture = null
		item_quantity.text = ""
		return
	
	item_icon.texture = slot.item.icon
	item_quantity.visible = slot.quantity > 1
	item_quantity.text = str(slot.quantity)
	
	item_icon.scale = Vector2.ONE / (item_icon.texture.get_size() / 16 ) * 0.7
