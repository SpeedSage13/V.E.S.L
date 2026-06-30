extends AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not Input.is_action_pressed("Input_Left") or Input.is_action_pressed("Input_Right") or Input.is_action_pressed("Input_Up") or Input.is_action_pressed("Input_Down"):
		play_Idle()

func play_Idle():
	$AnimatedSprite2D.play("Idle")
	
