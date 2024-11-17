extends Area2D
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var ui: UI = %UI

func _on_body_entered(body: Node2D) -> void:
	sprite.play("feedback")
	ui.adicionarPontos()

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "feedback":
		queue_free()
