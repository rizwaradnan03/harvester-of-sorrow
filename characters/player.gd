extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -400.0

var anim_player = null
var is_moving = false
var is_hitting = false

func _ready():
	anim_player = $Movement
	anim_player.play("idle_back")
	anim_player.connect("animation_finished", _on_movement_animation_finished)

func _stop_movement():
	is_moving = false
	is_hitting = false
	velocity.x = 0
	velocity.y = 0

func _get_last_direction():
	if anim_player.animation == "move_front" or anim_player.animation == "attack_front":
		anim_player.play("idle_front")
	elif anim_player.animation == "move_back" or anim_player.animation == "attack_back":
		anim_player.play("idle_back")
	elif anim_player.animation == "move_side" or anim_player.animation == "attack_side":
		anim_player.play("idle_side")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_front") && is_moving == false:
		anim_player.play("move_front")
		velocity.y = -1 * SPEED
		is_moving = true
		
		velocity.x = 0
	elif Input.is_action_just_released("move_front"):
		_stop_movement()
	
	if Input.is_action_pressed("move_back") && is_moving == false:
		anim_player.play("move_back")
		velocity.y = 1 * SPEED
		is_moving = true
		
		velocity.x = 0
	elif Input.is_action_just_released("move_back"):
		_stop_movement()

	if Input.is_action_pressed("move_right") && is_moving == false:
		anim_player.play("move_side")
		anim_player.flip_h = false
		velocity.x = 1 * SPEED
		is_moving = true
		
		velocity.y = 0
	elif Input.is_action_just_released("move_right"):
		_stop_movement()
	
	if Input.is_action_pressed("move_left"):
		anim_player.play("move_side")
		anim_player.flip_h = true
		velocity.x = -1 * SPEED
		is_moving = true
		
		velocity.y = 0
	elif Input.is_action_just_released("move_left"):
		_stop_movement()
	
	if Input.is_action_just_pressed("space") && is_moving == false:
		is_hitting = true
		if anim_player.animation == "move_back" or anim_player.animation == "idle_back":
			anim_player.play("attack_back")
			
		elif anim_player.animation == "move_front" or anim_player.animation == "idle_front":
			anim_player.play("attack_front")
		elif anim_player.animation == "move_side" or anim_player.animation == "idle_side":
			anim_player.play("attack_side")

	if anim_player.animation == "attack_front" or anim_player.animation == "attack_side" or anim_player.animation == "attack_back":
		if anim_player.frame == anim_player.sprite_frames.get_frame_count(anim_player.animation) - 1:
			is_hitting = false
			

	if is_moving == false and is_hitting == false:
		_get_last_direction()
	else:
		move_and_slide()
		
	Global.position_player = position

func _on_movement_animation_finished(anim_name) -> void:
	if anim_name.begins_with("attack_"):
		is_hitting = false
		_stop_movement()
