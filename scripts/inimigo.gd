extends Node2D
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var timer: Timer = $Timer

var SPEED = 40.0

var direction = 1

func _physics_process(delta: float) -> void:	
	position.x += direction * SPEED * delta
	
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	
	if direction > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "death":
		queue_free()

func _on_killzone_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player:
		if not player.sprite.animation == "fall":
			timer.start()
			player.DIED = true
		else:
			SPEED = 0
			sprite.animation = "death"
			player.velocity.y = player.JUMP_VELOCITY


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
