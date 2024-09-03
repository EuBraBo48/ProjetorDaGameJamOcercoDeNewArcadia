extends Label
class_name TimerManager

var tempo: int = 30
var NuOndas: int = 0
onready var timer_label = $"."

# Função que será chamada no timeout do Timer
func _on_Timer_timeout():
	tempo -= 1
	print(tempo)
	timer_label.text = str(tempo)
	
	if tempo == 0:
		_emit_wave_signal()
		print("Nova onda de zumbis!")
		NuOndas += 1
		
		tempo = 30

# Emite um sinal para iniciar uma nova onda de zumbis
func _emit_wave_signal():
	emit_signal("wave_finished")

# Função chamada quando a cena está pronta
func _ready() -> void:
	# Conecta o sinal `wave_finished` para que a lógica de criação de zumbis seja ativada em outro script
	if has_node("GeradorZumbis"):
		connect("wave_finished", get_node("GeradorZumbis"), "_on_wave_finished")
