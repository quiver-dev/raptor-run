extends Area2D

@export var value = 3

@onready var player = $"/root/World/Player"
@onready var sprite = $AnimatedSprite2d
@onready var pickup_sound = $PickupSound

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player.add_ammo(value)
		sprite.play("collected")
		pickup_sound.play()
		sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
