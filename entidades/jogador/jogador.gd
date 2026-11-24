extends CharacterBody2D

@export var velocidade: float = 70.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var ultima_direcao: String = "down"

func _physics_process(_delta: float) -> void:
	var direcao_horizontal : float = Input.get_axis("mover_esquerda", "mover_direita")
	var direcao_vertical : float = Input.get_axis("mover_cima", "mover_baixo")
	var direcao : Vector2 = Vector2(direcao_horizontal, direcao_vertical).normalized()
	velocity = velocidade * direcao
	
	if direcao != Vector2.ZERO:
		
		if abs(direcao_horizontal) > abs(direcao_vertical):
			if direcao_horizontal > 0:
				ultima_direcao = "right"
			else: 
				ultima_direcao = "left"
		else:
			if direcao_vertical > 0:
				ultima_direcao = "down"
			else:
				ultima_direcao = "up"
		
		sprite.play("run_" + ultima_direcao)
		
	else:
		sprite.play("idle_" + ultima_direcao)
		
	move_and_slide()
