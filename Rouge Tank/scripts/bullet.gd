extends Area2D

const MAX_DIST = 250

var vel = 250
# set_get sets a callback function every time the
# variable is modified (executes before ready method)
var dir = Vector2(0,-1) setget set_dir

# Bullet initial position
# set when object is readt
onready var init_pos = global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Destriy bullets with pos difference greater than MAX_DIST
	if global_position.distance_to(init_pos) >= MAX_DIST:
		queue_free()
	
	translate( dir *  vel * delta )


# When the bullet go out the screen
func _on_notifier_screen_exited():
	# Destroy this object (bullet)
	queue_free();

func set_dir(val):
	dir = val
	# Updates the bullet angle
	rotation = dir.angle()
