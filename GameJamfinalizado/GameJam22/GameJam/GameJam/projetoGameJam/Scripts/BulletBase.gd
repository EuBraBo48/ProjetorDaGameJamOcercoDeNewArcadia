extends Area2D
class_name Bullet

var direction : Vector2 = Vector2.ZERO
var velocity : int = 160
var damage : int = 0

export var collide : bool = true

func _physics_process(delta: float) -> void:
	moviment(delta)

func moviment(delta : float) -> void :
	position += direction * velocity * delta

func _on_DespawnTimer_timeout() -> void:
	queue_free()

func _on_BulletBase_body_entered(body: Node) -> void:
	if body.has_method("dano") :
		body.dano(damage)
		
		if collide == true :
			queue_free()
