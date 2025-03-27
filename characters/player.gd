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

	if is_moving == false:
		if anim_player.animation == "move_front":
			anim_player.play("idle_front")
		elif anim_player.animation == "move_back":
			anim_player.play("idle_back")
		elif anim_player.animation == "move_side":
			anim_player.play("idle_side")
			
	else:
		move_and_slide()


func _on_movement_animation_finished(anim_name) -> void:
	print("apakah selesai pler", anim_name)
	if anim_name.begins_with("attack_"):
		is_hitting = false
		_stop_movement()
