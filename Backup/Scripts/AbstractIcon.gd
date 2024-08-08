extends Sprite

var target : Node2D

func _physics_process(delta: float) -> void:
	if target :
		global_position += global_position.direction_to(target.global_position).normalized() * 2
		if abs(global_position.length() - target.global_position.length()) < 1.2 :
			queue_free()
