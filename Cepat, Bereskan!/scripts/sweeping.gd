extends Node2D
class_name Sweeping

var moves:Array = []
var move_index:int = 0
var broom_sfx:Array = [preload("res://assets/Broom Var. 1.wav"), preload("res://assets/Broom Var. 2.wav"), preload("res://assets/Broom Var. 3.wav"), preload("res://assets/Broom Var. 4.wav")]

func rotate_arrow():
	match moves[move_index]:
		"ui_left":
			$arrow.rotation = PI
		"ui_right":
			$arrow.rotation = 0

func _ready() -> void:
	for i in range(10):
		moves.append(["ui_left", "ui_right"].pick_random())
	rotate_arrow()

func _process(delta: float) -> void:
	if move_index == moves.size()-1:
		queue_free()
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		$sfx.stream = broom_sfx.pick_random()
		$sfx.play()
		if Input.is_action_just_pressed(moves[move_index]):
			move_index += 1
			rotate_arrow()
		else:
			move_index = 0
			rotate_arrow()
