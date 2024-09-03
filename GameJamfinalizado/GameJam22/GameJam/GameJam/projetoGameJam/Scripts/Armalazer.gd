extends FireWeaponBase

var active = false

func process(delta: float) -> void:
	if Input.is_action_pressed("Click") :
		$LazerArea.show()
		active = true
		$AudioStreamPlayer.play()
	
	elif Input.is_action_just_released("Click") :
		$LazerArea.hide()
		active = false

func _on_CooldownTimer_timeou() -> void:
	if active == false :
		return
	for i in $LazerArea.get_overlapping_bodies() :
		if i.has_method("dano") :
			i.dano(item.damage)
