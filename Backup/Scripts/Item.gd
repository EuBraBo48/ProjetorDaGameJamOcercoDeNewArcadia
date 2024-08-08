extends Resource
class_name Item

export var name : String 
export var maxQuantity : int 
export var icon : Texture

func enter() -> void :
	pass

func exit() -> void :
	pass

func use() -> void :
	pass

func process(delta) -> void :
	pass

func physics_process(delta) -> void :
	pass

func input(event) -> void :
	if event as InputEventMouseButton and event.is_pressed() :
		print(232)
