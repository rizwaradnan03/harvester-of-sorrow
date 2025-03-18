extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -400.0

var anim_player = null
var is_moving = false

func _ready():
	anim_player = $Movement
	anim_player.play("idle_back")

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("move_front"):
		anim_player.play("move_front")
		velocity.y = -1 * SPEED
		is_moving = true
		
		velocity.x = 0
	elif Input.is_action_pressed("move_back"):
		anim_player.play("move_back")
		velocity.y = 1 * SPEED
		is_moving = true
		
		velocity.x = 0
	elif Input.is_action_pressed("move_right"):
		anim_player.play("move_side")
		anim_player.flip_h = false
		velocity.x = 1 * SPEED
		is_moving = true
		
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		anim_player.play("move_side")
		anim_player.flip_h = true
		velocity.x = -1 * SPEED
		is_moving = true
		
		velocity.y = 0
	else:
		is_moving = false
		velocity.y = 0
		velocity.x = 0
	
	if is_moving == false:
		if anim_player.animation == "move_front":
			anim_player.play("idle_front")
		elif anim_player.animation == "move_back":
			anim_player.play("idle_back")
		elif anim_player.animation == "move_side":
			anim_player.play("idle_side")
			
			
	else:
		move_and_slide()
