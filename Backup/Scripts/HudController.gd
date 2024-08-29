extends CanvasLayer
class_name HudController

export(NodePath) var playerPath 
var player : Node2D

var huds : Dictionary = {}
onready var activeHud : HudBase = $HotbarHud

func _ready() -> void:
	player = get_node(playerPath)
	
	for child in get_children() :
		huds[child.name.to_lower()] = child
		child.player = player
		child.start()
	if activeHud :
		activeHud.open()

func _input(event: InputEvent) -> void :
	if activeHud :
		activeHud.input(event)

func _process(delta : float) -> void :
	if activeHud :
		activeHud.process(delta)
	
	if Input.is_action_just_pressed("INVENTORY") :
		if activeHud is InventoryHud and huds["InventoryHud".to_lower()].animations.is_playing() == false:
			transite_hud("HotbarHud")
		elif huds["InventoryHud".to_lower()].animations.is_playing() == false :
			transite_hud("InventoryHud")

func _physics_process(delta : float) -> void :
	if activeHud :
		activeHud.physics_process(delta)

func transite_hud(newHud : String) -> void :
	if huds[newHud.to_lower()] == null :
		print("Esse hud num existe nom meu parceiro")
		return
	
	if activeHud :
		activeHud.close()
	
	activeHud = huds[newHud.to_lower()]
	activeHud.open()

