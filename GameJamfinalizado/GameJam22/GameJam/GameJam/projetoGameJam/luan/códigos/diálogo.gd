extends NinePatchRect


onready var text := $RichTextLabel
var msg_queue: Array = [
	"Tu se lembra de seu dever?",
	"Negativo? Portanto vou refrescar sua memoria",
	"Uma empresa farmaceutica teve uma brilhante ideia de criar uma subtância que supostamente transformaria a humanidade em 'seres super evoluídos'",
	"Adivinha? Logico que nao deu certo e agora estamos aqui tendo que acabar com esse virus",
	"Boa sorte!"
] 

func _ready():
	show_message()
	print("TET2")

func _input(event):
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		show_message()
		print("TETE 1")

func show_message() -> void:
	if msg_queue.size() == 0:
		hide()
		get_tree().change_scene("res://EuBraBo/scenes/MAIN.tscn")
		print('tttt')
		return
	var _msg: String = msg_queue.pop_front()
	if _msg:
		text.bbcode_text = _msg
		print("55")
	else:
		text.bbcode_text = ""
		print("IMMM")
	text.bbcode_text = _msg
