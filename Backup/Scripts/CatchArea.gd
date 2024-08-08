extends Area2D
class_name CatchArea

func _physics_process(delta):
	for area in get_overlapping_areas() :
		if area is AbstractItem :
			
			if area.can_picked == true and get_parent().inv.add_item(area.item) == [] :
				area.pick(get_parent())

