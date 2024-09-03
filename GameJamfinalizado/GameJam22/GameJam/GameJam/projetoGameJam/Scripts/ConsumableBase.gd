extends ItemBase
class_name ConsumableBase

onready var animations: AnimationPlayer = $Animations

export var eatVelocity := 2
var eatPorcent := 0

func enter() :
	$Icon.texture = item.icon

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("Click") and eatPorcent < 100 :
		eatPorcent = move_toward(eatPorcent, 100, eatVelocity)
		animations.play("Eat")
		get_parent().canSwap = false
		
		if eatPorcent == 100 :
			consume()
			eatPorcent == 101
	elif Input.is_action_just_released("Click") :
		eatPorcent = 0
		animations.play("RESET")
		get_parent().canSwap = true

func consume() :
	player.health += item.health
	player.stamina += item.stamina
	player.hunger += item.hunger
	player.water += item.water
	player.max_health += item.maxHealth
	
	get_parent().get_parent().inv.remove_item(get_parent().hotbar.currentSlot, 1)
	get_parent().canSwap = true
	

