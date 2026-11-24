extends CharacterBody2D

@export var velocidade: float = 70.0

func _physics_process(_delta: float) -> void:
	var direcao_horizontal : float = Input.get_axis("mover_esquerda", "mover_direita")
	var direcao_vertical : float = Input.get_axis("mover_cima", "mover_baixo")
	var direcao : Vector2 = Vector2(direcao_horizontal, direcao_vertical).normalized()
	velocity = velocidade * direcao
	
	move_and_slide()
