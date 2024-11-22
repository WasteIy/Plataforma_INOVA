extends CharacterBody2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


var SPEED = 50.0
var direction = 1


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	
	if direction > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	move_and_slide()
	


func _on_killzone_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player:
		if player.sprite.animation == "fall":
			player.velocity.y = player.JUMP_VELOCITY
			SPEED = 0
			sprite.play("death")
		else:
			player.DIED = true
			timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "death":
		queue_free()
