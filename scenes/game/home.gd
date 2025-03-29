extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.packaged_player:
		add_child(Global.packaged_player)
		Global.packaged_player = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
