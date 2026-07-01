extends Control
func _ready():
	hide()
func pause():
	get_tree().paused = true
	show()

func resume():
	get_tree().paused = false
	hide()

# Pause game
func escape():
	if Input.is_action_just_pressed("Input_quit") and !get_tree().paused:
		pause()

	elif Input.is_action_just_pressed("Input_quit") and get_tree().paused:
		resume()


func _on_save_quit_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://UI's/StartScreen/start_screen.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Success's stuff/testing_stage.tscn")
func _process(delta):
	escape()
