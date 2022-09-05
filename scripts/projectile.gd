extends AnimatableBody2D

var death_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	death_time = Time.get_ticks_msec() + 2000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Time.get_ticks_msec() >= death_time:
		queue_free()

func _physics_process(delta):
	var distance = Vector2.RIGHT * 1000 * delta
	var collision = move_and_collide(distance)
	
	if collision:
		queue_free()
		if collision.get_collider().is_in_group("enemy"):
			collision.get_collider().die()
