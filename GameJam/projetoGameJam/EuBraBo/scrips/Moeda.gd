extends AnimatedSprite
class_name Moeda



export (NodePath) var hud_path
onready var hud = get_node(hud_path)


func _on_colio_body_entered(_body):
	if _body.is_in_group("Player"):
		print("teste")
		hud.NuMoedas += 1
