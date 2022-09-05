extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.set_active(true)

func _on_body_exited(body):
	if body.is_in_group("enemy"):
		body.queue_free()
