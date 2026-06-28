extends CharacterBody2D

const SPEED = 10
const RUN_SPEED = 600.0
const JUMP_VELOCITY = -400.0
var gravity = 25

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity

	# Handle jump
	if Input.is_action_just_pressed("Input_Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

		
	#Handles Idle, Run, and Jump Animations.
	if not Input.is_action_pressed("Input_Left") and not Input.is_action_pressed("Input_Right") and not Input.is_action_pressed("Input_Up") and not Input.is_action_pressed("Input_Down") and is_on_floor():
		$Character_Sprites.play("Idle")
	else:
		if Input.is_action_pressed("Input_Left") and is_on_floor():
			$Character_Sprites.flip_h = true
			$Character_Sprites.play("Run")
			if not is_on_floor():
				$Character_Sprites.stop()
		elif Input.is_action_pressed("Input_Right") and is_on_floor():
			$Character_Sprites.flip_h = false
			$Character_Sprites.play("Run")
			if not is_on_floor():
				$Character_Sprites.stop()
		elif Input.is_action_pressed("Input_Up") and is_on_floor():
			$Character_Sprites.play("Jump")
			

	#Set a Sprint Action for the player to speed up with.
	#should smoothly switch between sprinting and walking.
	var running := Input.is_action_pressed("Sprint")
	var direction := Input.get_axis("Input_Left", "Input_Right")
	if direction and not running:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction and running:
		while not velocity.x == RUN_SPEED:
			velocity.x += 1
	move_and_slide()
