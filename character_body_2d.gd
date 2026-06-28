extends CharacterBody2D


const SPEED = 300.0
const RUN_SPEED = 700.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += 20.0

	# Handle jump.
	if Input.is_action_just_pressed("Input_Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Handles Idle Animation supposedly??
	if not Input.is_action_pressed("Input_Left") or not Input.is_action_pressed("Input_Right") or not Input.is_action_pressed("Input_Up") or not Input.is_action_pressed("Input_Down") and is_on_floor():
		$Character_Sprites.play("Idle")
	
	if Input.is_action_pressed("Input_Left"):
		$Character_Sprites.flip_h = true
		$Character_Sprites.play("Run")
	elif Input.is_action_pressed("Input_Right"):
			$Character_Sprites.flip_h = false
			$Character_Sprites.play("Run")

	#Set running speed to a different button, may change later.
	var running := Input.is_action_pressed("Sprint")
	var direction := Input.get_axis("Input_Left", "Input_Right")
	if direction and not running:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction and running:
		velocity.x = direction * RUN_SPEED

	move_and_slide()
