extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
var character
var anim_player

const SPEED = 6
const ACCERLERATION = 3
const DE_ACCELERATION = 5

var score = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	character = get_node(".")
	#pass # Replace with function body.

func _physics_process(delta):
	camera = get_node("Camera").get_global_transform()
	anim_player = get_node("Armature/AnimationPlayer")
	var dir = Vector3()
	var is_moving = false
	
	if(Input.is_action_pressed("move_fw")):
		dir += -camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_bw")):
		dir += camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_l")):
		dir += -camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("move_r")):
		dir += camera.basis[0]
		is_moving = true
	
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if(dir.dot(hv) > 0):
		accel = ACCERLERATION
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	if(Input.is_action_pressed("jump") and is_on_floor()):
		velocity.y = 5
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	if is_moving:
		var angle = atan2(hv.x, hv.z)
		
		var char_rot = character.get_rotation()
		char_rot.y = angle
		character.set_rotation(char_rot)
		
	var anim_to_play = "idle-loop"
	if is_moving:
		anim_to_play = "walk-cycle"
		#anim_to_play = "idle-loop"
	
	var current_anim = anim_player.get_current_animation()
	if current_anim != anim_to_play:
		anim_player.play(anim_to_play)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
