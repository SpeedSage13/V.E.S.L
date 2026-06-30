extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_start_pressed():
	print("hello world")
	get_tree().change_scene_to_file("res://Start Screen Testing/TestScene.tscn")
