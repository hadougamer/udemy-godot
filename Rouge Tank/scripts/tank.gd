extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Multiply for delta to convert px per frame to px per second
	translate( Vector2(-100,-50) * delta )
	pass
