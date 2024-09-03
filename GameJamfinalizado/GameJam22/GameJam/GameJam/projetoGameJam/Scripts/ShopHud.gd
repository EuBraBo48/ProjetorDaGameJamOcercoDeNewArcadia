extends HudBase
class_name ShopHud

onready var shop_base: TextureRect = $Control/ShopBase
onready var animations: AnimationPlayer = $Animations


var itemList := [[
preload("res://Scripts/Chocolate.tres"), 
preload("res://Scripts/Frango.tres"),
preload("res://Scripts/Brocolis.tres"),
preload("res://Scripts/Leite.tres"),
preload("res://Scripts/PotionVermelha.tres"),
preload("res://Scripts/Banana.tres"),
preload("res://Scripts/PotionAzul.tres"),
preload("res://Scripts/KitMedico.tres")
],[
preload("res://Scripts/PistolaPlasma.tres"),
preload("res://Scripts/RifleDePlasma.tres"),
preload("res://Scripts/Bazooka.tres"),
preload("res://Scripts/ArmaLazer.tres"),
preload("res://Scripts/LancaChamas.tres"),
preload("res://Scripts/Desintegrador.tres"),
preload("res://Scripts/Espingarda.tres")
]]
var itensShop = [null, null, null]

func _ready() -> void:
	randomize()
	for part in shop_base.get_children() :
		part.get_node("ItemIcon").rect_scale = Vector2.ONE / (part.get_node("ItemIcon").texture.get_size() / 16) * 1.4

func placeItens() :
	var itens = itemList.duplicate()
	
	var ind = 0 
	for part in shop_base.get_children() :
		var itemIndex
		var item
		
		if part.name in ["ShopPart1","ShopPart3"] :
			itemIndex = rand_range(0, itens[0].size())
			item = itens[0][itemIndex] if not itens[0] == [] else null
		else :
			itemIndex = rand_range(0, itens[1].size())
			item = itens[1][itemIndex] if not itens[1] == [] else null
		
#		itens.erase(item)
		
		itensShop[ind] = item
		ind += 1
		
		if item == null :
			part.get_node("ItemName").text = ""
			part.get_node("ItemIcon").texture = null
			part.get_node("ItemDescription").text = ""
			part.get_node("CoinsQuantity").text = ""
			part.get_node("BuyText").hide()
			
			continue
		
		part.get_node("ItemName").text = item.name
		part.get_node("ItemIcon").texture = item.icon
		part.get_node("ItemDescription").text = item.description
		part.get_node("CoinsQuantity").text = str(item.value) + " c"
		part.get_node("BuyText").show()

func buy_item(index : int) :
	if itensShop[index - 1 ] == null :
		return
	
	var part = shop_base.get_child(index - 1)
	
	if get_parent().get_node(get_parent().hudBraboPath).NuMoedas >= itensShop[index - 1 ].value :
		get_parent().get_node(get_parent().hudBraboPath).NuMoedas -= itensShop[index - 1 ].value
		player.inv.add_item(itensShop[index - 1 ])
		
		itensShop[index - 1 ] = null
		
		part.get_node("ItemName").text = ""
		part.get_node("ItemIcon").texture = null
		part.get_node("ItemDescription").text = ""
		part.get_node("CoinsQuantity").text = ""
		part.get_node("BuyText").hide()
	
	var nullParts := 0
	for itein in itensShop :
		if itein == null :
			nullParts += 1
	if nullParts == 3 :
		get_parent().get_node(get_parent().hudBraboPath).waves_restart()
		

func open() -> void :
	animations.play("Open")
	player.canMove = false
	placeItens()
	get_parent().sounds.player()
	$AudioStreamPlayer.play()

func close() -> void :
	animations.play("Close")
	player.canMove = true
	get_parent().sounds.stop()
	$AudioStreamPlayer.stop()
	


func _on_Button1_pressed() -> void:
	buy_item(1)

func _on_Button2_pressed() -> void:
	buy_item(2)

func _on_Button_pressed() -> void:
	buy_item(3)
