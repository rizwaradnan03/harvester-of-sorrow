extends StaticBody2D

var anim_player = null
var x_direction = null
var y_direction = null
var is_moving = false

func _ready() -> void:
	anim_player = $AnimatedSprite2D
	x_direction = 0
	y_direction = 0

func _process(delta: float) -> void:
	var x_direction = Global.position_player.x - position.x
	var y_direction = Global.position_player.y - position.y
		
	if abs(x_direction) > abs(y_direction):
		if abs(Global.position_player.x - position.x) <= 15:
			is_moving = false
		else:
			is_moving = true
			anim_player.play("move_side")
			
	elif abs(x_direction) < abs(y_direction):
		if abs(Global.position_player.y - position.y) <= 15:
			is_moving = false
		else:
			is_moving = true
			if y_direction > 0:
				anim_player.play("move_back")
			else:
				anim_player.play("move_front")
	
	if is_moving == true:
		if x_direction > 0:
			anim_player.flip_h = false
		else:
			anim_player.flip_h = true
			
		if x_direction > 0:
			position.x += 0.5
		else:
			position.x -= 0.5
				
		if y_direction > 0:
			position.y += 0.5
		else:
			position.y -= 0.5
	else:
		if anim_player.animation == "move_front":
			anim_player.play("idle_front")
		elif anim_player.animation == "move_side":
			anim_player.play("idle_side")
		elif anim_player.animation == "move_back":
			anim_player.play("idle_back")
		
