extends KinematicBody2D

var speed=200

func _ready():
	pass

func _process(delta):
	
	var dir_x=0;
	var dir_y=0;
	
	if Input.is_action_pressed("ui_right"):
		dir_x+=1
	elif Input.is_action_pressed("ui_left"):
		dir_x-=1
		
	if Input.is_action_pressed("ui_up"):
		dir_y-=1
	elif Input.is_action_pressed("ui_down"):
		dir_y+=1
		
	if Input.is_action_just_pressed("ui_shoot"):
		print("boom")
	
	translate( Vector2(dir_x, dir_y) * delta * speed )
	
	pass
