extends AnimatedSprite
class_name Moeda

onready var hud = get_tree().root.get_child(0).get_node("HUD/hud")

func _on_colio_body_entered(_body):
	if _body.is_in_group("Player"):
		print("teste")
		hud.NuMoedas += 4
		queue_free()
