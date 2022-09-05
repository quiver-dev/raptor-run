extends CharacterBody2D

@export var gravity = 1600

func _ready():
	print("hello world")

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()
