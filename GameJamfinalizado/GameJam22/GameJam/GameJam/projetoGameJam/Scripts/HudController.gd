extends CanvasLayer
class_name HudController

onready var sounds = $"../../sounds"

export(NodePath) var hudBraboPath 
export(NodePath) var itemControllerPath 
export(NodePath) var playerPath 
onready var pause_menu = $"../pause_menu"


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
		pause_menu._on_resume_btn_pressed()
		if activeHud is InventoryHud and huds["InventoryHud".to_lower()].animations.is_playing() == false:
			transite_hud("HotbarHud")
		elif huds["InventoryHud".to_lower()].animations.is_playing() == false and activeHud is HotbarHud  :
			transite_hud("InventoryHud")
	
	if activeHud is ShopHud and Input.is_action_pressed("ui_accept") :
		get_node(hudBraboPath).waves_restart()

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

