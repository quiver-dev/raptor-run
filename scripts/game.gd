extends Node2D

@export var world_speed = 300
@export var collectible_pitch_reset_interval = 2000

@onready var moving_environment = $"/root/World/Environment/Moving"
@onready var collect_sound = $"/root/World/Sounds/CollectSound"

var platform = preload("res://scenes/platform.tscn")
var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0
var score = 0
var collectible_pitch = 1.0
var reset_collectible_pitch_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Reset the collectible sound pitch after a time
	if Time.get_ticks_msec() > reset_collectible_pitch_time:
		collectible_pitch = 1.0
	
	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()

func _spawn_next_platform():
	var new_platform = platform.instantiate()
		
	# Set the position of the new platform
	if last_platform_position == Vector2.ZERO:
		new_platform.position = Vector2(400, 0)
	else:
		var x = last_platform_position.x + rng.randi_range(450, 550)
		var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 1000)
		new_platform.position = Vector2(x, y)
	
	# Add the platform to the moving environment
	moving_environment.add_child(new_platform)
	
	# Update the last platform position and increase the next spawn time
	last_platform_position = new_platform.position
	next_spawn_time += world_speed
	
func _physics_process(delta):
	# Move the platforms left
	moving_environment.position.x -= world_speed * delta

func add_score(value):
	score += value
	collect_sound.set_pitch_scale(collectible_pitch)
	collect_sound.play()
	collectible_pitch += 0.1
	reset_collectible_pitch_time = Time.get_ticks_msec() + collectible_pitch_reset_interval
	print(score)
