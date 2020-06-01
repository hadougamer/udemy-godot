tool
extends KinematicBody2D

# PI: 180 degrees
const ROT_VEL = PI/2

const MAX_SPEED=200
var acel = 0 #acceleration

# Loads scene from library
var pre_bullet=preload("res://scenes/bullet.tscn")

# Bullet group name
var BULLET_TANK_GROUP = "bullet-" + str(self)

# Export variables are avaiable outside this object
export(
	int, 
	"bigRed", 
	"blue", 
	"dark", 
	"darkLarge", 
	"huge", 
	"red", 
	"sand"
) var body   = 3 setget set_body #register a callback

export var barrel = 4 setget set_barrel

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
	print(self)
	pass
	
func _draw():
	$Sprite.texture = load(bodies[ body ])
	$"barrel/sprite".texture = load(barrels[ barrel ])

func _physics_process(delta):
	if Engine.editor_hint:
		return
	
#	var dir_x=0;
#	var dir_y=0;
#
#	if Input.is_action_pressed("ui_right"):
#		dir_x+=1
#	elif Input.is_action_pressed("ui_left"):
#		dir_x-=1
#
#	if Input.is_action_pressed("ui_up"):
#		dir_y-=1
#	elif Input.is_action_pressed("ui_down"):
#		dir_y+=1
#
	if Input.is_action_just_pressed("ui_shoot"):
		# Get the number of bullets (on cannon bullet group)
		# limit the number of bullets to max three (3)
		if get_tree().get_nodes_in_group( BULLET_TANK_GROUP ).size() < 9:

			# Instances bullet
			var bullet = pre_bullet.instance()
			# Put on Muzzle position
			bullet.global_position=$barrel/muzzle.global_position

			# Modify the bullet rirection (to rotate)
			bullet.dir = Vector2( cos(rotation), sin(rotation) ).normalized()

			# Add the bullet to the current cannon group			
			bullet.add_to_group( BULLET_TANK_GROUP )

			#attach to parent
			$"../".add_child(bullet)
			$barrel/anim.play("fire")
			##get_parent().add_child(bullet);
#
#	look_at(get_global_mouse_position())
#
#	move_and_slide( Vector2(dir_x, dir_y) * speed )

	var rot  = 0 #rotation
	var dir  = 0 # direction
	
	if Input.is_action_pressed("ui_right"):
		rot += 1
	
	if Input.is_action_pressed("ui_left"):
		rot -= 1
		
	if Input.is_action_pressed("ui_up"):
		dir += 1
	
	if Input.is_action_pressed("ui_down"):
		dir -= 1

	rotate( ROT_VEL * rot * delta )
	
	if dir != 0:
		# Lerp interpolates from 0 to max speed
		acel = lerp(acel, MAX_SPEED * dir, .1)
	else:
		# Lerp interpolates from max speed to 0
		acel = lerp(acel, 0, .1)		
	
	print(acel)
	
	# Rotation Sin and Cos updates the front angle to move for 
	move_and_slide(Vector2(cos(rotation), sin(rotation)) * acel )
	
	
func set_body(value):
	body=value # change body value
	if Engine.editor_hint:
		# On editor mode
		update() # redraw the object
		
func set_barrel(value):
	barrel=value # change body value
	if Engine.editor_hint:
		# On editor mode
		update() # redraw the object
