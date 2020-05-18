extends KinematicBody2D

var speed=200

# Loads scene from library
var pre_bullet=preload("res://scenes/bullet.tscn")

# Tank skin list
var bodies = [
	"res://sprites/tankBody_bigRed.png",
	"res://sprites/tankBody_blue.png",
	"res://sprites/tankBody_dark.png",
	"res://sprites/tankBody_darkLarge.png",
	"res://sprites/tankBody_green.png",
	"res://sprites/tankBody_huge.png",
	"res://sprites/tankBody_red.png",
	"res://sprites/tankBody_sand.png"
]

# barrels skin list
var barrels = [
	"res://sprites/tankDark_barrel1.png",
	"res://sprites/tankDark_barrel1_outline.png",
	"res://sprites/tankGreen_barrel1.png",
	"res://sprites/tankRed_barrel1.png",
	"res://sprites/tankSand_barrel1.png",
	"res://sprites/tankSand_barrel3.png"
]

func _ready():
	$Sprite.texture = load(bodies[1])
	$"barrel/sprite".texture = load(barrels[4])
	
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
		# Get the number of bullets (on cannon bullet group)
		# limit the number of bullets to max three (3)
		if get_tree().get_nodes_in_group("cannon_bullet").size() < 9:
			
			# Instances bullet
			var bullet = pre_bullet.instance()
			# Put on Muzzle position
			bullet.global_position=$barrel/muzzle.global_position
			
			# Modify the bullet rirection (to rotate)
			bullet.dir = Vector2( cos(rotation), sin(rotation) ).normalized()
			
			#attach to parent
			$"../".add_child(bullet)
			$barrel/anim.play("fire")
			##get_parent().add_child(bullet);

	look_at(get_global_mouse_position())
				
	translate( Vector2(dir_x, dir_y) * delta * speed )
	
	pass
