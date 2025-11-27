extends Node2D
class_name Sweeping

var moves:Array = []
var move_index:int = 0
var broom_sfx:Array = [preload("res://assets/Sweeping Assets/Broom Var. 1.wav"), preload("res://assets/Sweeping Assets/Broom Var. 2.wav"), preload("res://assets/Sweeping Assets/Broom Var. 3.wav"), preload("res://assets/Sweeping Assets/Broom Var. 4.wav")]
var broom: Sprite2D = null

func rotate_arrow():
	match moves[move_index]:
		"ui_left":
			$arrow.rotation = PI
		"ui_right":
			$arrow.rotation = 0
		"ui_up":
			$arrow.rotation = -PI/2
		"ui_down":
			$arrow.rotation = PI/2

func _ready() -> void:
	$arrow.material = $arrow.material.duplicate()
	for i in range(10):
		moves.append(["ui_left", "ui_right", "ui_up", "ui_down"].pick_random())
	rotate_arrow()

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
		$sfx.stream = broom_sfx.pick_random()
		$sfx.play()
		if Input.is_action_just_released(moves[move_index]):
			move_index += 1
			$Dust2.modulate.a -= 0.1
			if move_index == moves.size():
				queue_free()
			else:
				rotate_arrow()
		else:
			move_index = 0
			$Dust2.modulate.a = 1
			rotate_arrow()

	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		$arrow.material.set_shader_parameter("modulate", Color.MISTY_ROSE)
	else:
		$arrow.material.set_shader_parameter("modulate", null)
	
	if broom:
		pass
		
	else:
		if Input.is_action_just_pressed("ui_left"):
			spawn_broom()
			var tween = create_tween()
			tween.parallel().tween_property(broom, "position", Vector2(500,280), 0.2)
			tween.parallel().tween_property(broom, "rotation", 0.2, 0.2)
			tween.tween_callback(func():
				if broom.position.x == 500:
					broom.queue_free()
			)
			
		if Input.is_action_just_pressed("ui_right"):
			spawn_broom()
			broom.scale.x = -2.3
			var tween = create_tween()
			tween.parallel().tween_property(broom, "position", Vector2(650,280), 0.2)
			tween.parallel().tween_property(broom, "rotation", -0.2, 0.2)
			tween.tween_callback(func():
				if broom.position.x == 650:
					broom.queue_free()
			)
			
		if Input.is_action_just_pressed("ui_up"):
			spawn_broom()
			var tween = create_tween()
			tween.parallel().tween_property(broom, "position", Vector2(600,210), 0.2)
			tween.parallel().tween_property(broom, "rotation", 0.5, 0.1)
			tween.tween_callback(func():
				if broom.position.y == 210:
					broom.queue_free()
			)
			
		if Input.is_action_just_pressed("ui_down"):
			spawn_broom()
			broom.position.x = 625
			broom.scale.x = -2.3
			broom.rotation = 0.6
			var tween = create_tween()
			tween.parallel().tween_property(broom, "position", Vector2(650,380), 0.2)
			tween.parallel().tween_property(broom, "rotation", 0.3, 0.1)
			tween.tween_callback(func():
				if broom.position.y == 380:
					broom.queue_free()
			)

func spawn_broom():
	broom = Sprite2D.new()
	add_child(broom)
	broom.texture = preload("res://assets/Sweeping Assets/actual broom.png")
	broom.position = Vector2(575, 280)
	broom.rotation = 0
	broom.scale = Vector2(2.3, 2.3)
