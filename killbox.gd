extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body):
	print("ERR! V.E.S.L. 201983 UNRESPONSIVE")
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
