extends Node2D

@export var world_speed = 300

@onready var moving_environment = $"/root/World/Environment/Moving"

func _physics_process(delta):
	# Move the platforms left
	moving_environment.position.x -= world_speed * delta
