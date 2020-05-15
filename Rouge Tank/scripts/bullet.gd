extends Area2D

var vel = 250
var dir = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate( dir *  vel * delta )


# When the bullet go out the screen
func _on_notifier_screen_exited():
	# Destroy this object (bullet)
	queue_free();
