extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var killzone_hitbox: CollisionShape2D = $Killzone/CollisionShape2D


var SPEED = 70.0
var JUMP_VELOCITY = -230.0
var direction = 1


func _physics_process(delta: float) -> void:
	if sprite.animation == "death":
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.x = direction * SPEED
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
	else:
		velocity.x = 0
		if sprite.animation != "idle":
			sprite.play("idle")

	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "idle":
		direction = -direction
		sprite.flip_h = !sprite.flip_h
		velocity.y = JUMP_VELOCITY
	if sprite.animation == "death":
		queue_free()
		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player:
		if player.sprite.animation == "fall":
			player.velocity.y = player.JUMP_VELOCITY
			SPEED = 0
			JUMP_VELOCITY = 0
			sprite.play("death")
			killzone_hitbox.disabled = true
		else:
			player.DIED = true
			timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
