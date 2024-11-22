extends CharacterBody2D
class_name Player
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D


var SPEED = 130.0
const JUMP_VELOCITY = -260.0
var DIED = false

func _physics_process(delta: float) -> void:
	if DIED == true:
		sprite.play("death")
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if Input.is_action_pressed("crouch"):
			global_position.y += 5
		else: 
			velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")

	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
