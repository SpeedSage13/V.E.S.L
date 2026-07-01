extends CharacterBody2D


const SPEED = 30.0
const JUMP_VELOCITY = -400.0
var direction = -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.x = SPEED * direction
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	



func _on_wallcheck_body_entered(body: Node2D) -> void:
	flip()





func flip():
	direction *= -1
	scale.x *= -1
