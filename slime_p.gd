extends Node2D

const SPEED = 60

var direction = 1
var gravity = 0
var max_enemy_health: = 20
var enemy_health: = max_enemy_health
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func take_damage(amount):
	enemy_health -= amount
	if enemy_health <= 0:
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_down.is_colliding():
		gravity = 0
	else:
		gravity = 3
	position.x += direction * 60 * delta
	position.y += gravity * 60 * delta
