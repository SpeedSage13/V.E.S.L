extends CharacterBody2D

const SPEED = 150
const RUN_SPEED = 500.0
const JUMP_VELOCITY = -400.0
var gravity = 20

var friction = 25
var dodging = Input.is_action_pressed("Dodge or wtv")
var dodge_speed = 500

var friction2 = 10
var max_health = 100
var health = max_health
var attacking := false
@onready var healthbar: ProgressBar = $"../healthbar"
@onready var attack_hitbox: Area2D = $"attack hitbox"
@onready var sprites: AnimatedSprite2D = $Character_Sprites


func _physics_process(delta: float) -> void:
	
	#Adds the gravity.
	if not is_on_floor():
		velocity.y += gravity
	
	# Handle jump
	if Input.is_action_just_pressed("Input_Up") and is_on_floor() and not dodging:
		velocity.y = JUMP_VELOCITY

	#Handles Idle, Run, and Jump Animations.
	if not Input.is_action_pressed("Input_Left") and not Input.is_action_pressed("Input_Right") and not Input.is_action_pressed("Input_Down") and is_on_floor() and not dodging:
		$Character_Sprites.play("Idle")
	else:
		if Input.is_action_pressed("Input_Left") and is_on_floor_only() and velocity.x <= 300 and velocity.x >= -300 and not dodging:
			$Character_Sprites.flip_h = true
			$Character_Sprites.play("Run")
		elif velocity.x >= 300 or velocity.x <= -300 and not dodging:
				$Character_Sprites.play("Sprint") 
		elif Input.is_action_pressed("Input_Right") and is_on_floor() and velocity.x <= 300 and velocity.x >= -300 and not dodging:
			$Character_Sprites.flip_h = false
			$Character_Sprites.play("Run")
		elif velocity.x >= 300 or velocity.x <= -300 and not dodging:
				$Character_Sprites.play("Sprint") 
		elif not is_on_floor():
			$Character_Sprites.play("Jump")
		elif Input.is_action_pressed("Input_Down") and velocity.x == 0 and is_on_floor() and not dodging:
			$Character_Sprites.play("Crouch")
			
	#This handles the player's ground movement/sprint speed.
	var running := Input.is_action_pressed("Sprint")
	var direction := Input.get_axis("Input_Left", "Input_Right")
	if direction and not running:
		if direction == -1:
			velocity.x = move_toward(velocity.x, SPEED * -1, friction)
			print(velocity.x, direction, friction)
		elif direction == 1:
				velocity.x = move_toward(velocity.x, SPEED, friction)
				print(str(velocity.x) + str(direction) + str(friction))
	elif not direction and not running:
		velocity.x = move_toward(velocity.x, 0, friction) 
	if direction and running:
		if not velocity.x == RUN_SPEED or RUN_SPEED * -1:
			if direction == -1:
				velocity.x = move_toward(velocity.x, (RUN_SPEED * -1), friction)
			elif direction == 1:
				velocity.x = move_toward(velocity.x, RUN_SPEED, friction)
	elif not direction and running:
		velocity.x = move_toward(velocity.x, 0, friction)
	if Input.is_action_just_pressed("Dodge or wtv") and $Character_Sprites.flip_h == false:
		velocity.x = move_toward(dodge_speed,  0, friction)
		$Player_Hitbox.disabled = true
		await get_tree().create_timer(0.1).timeout
		$Player_Hitbox.disabled = false
	elif Input.is_action_just_pressed("Dodge or wtv") and $Character_Sprites.flip_h == true:
		velocity.x = move_toward(dodge_speed * -1,  0, friction)
		$Player_Hitbox.disabled = true
		await get_tree().create_timer(0.1).timeout
		$Player_Hitbox.disabled = false
	move_and_slide()
	

	
func take_damage_player(amount: int) -> void:
	health -= amount
	health = clamp(health, 0, max_health)
	if healthbar:
		healthbar.value=health
	emit_signal("health_down")
