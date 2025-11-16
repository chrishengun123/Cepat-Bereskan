extends CharacterBody2D

@export var Character: Node2D

func _physics_process(delta: float) -> void:
	var dir_x = Input.get_axis("ui_left", "ui_right") # Change these to wsad
	var dir_y = Input.get_axis("ui_up", "ui_down")
	move_and_collide(Vector2(Consts.SPEED * dir_x, Consts.SPEED * dir_y) * delta)

	rotation(dir_x, dir_y)

func rotation(dir_x: float, dir_y: float) -> void:
	var sprite = Character.get_node("AnimatedSprite2D")

	if dir_x > 0:
		rotation_degrees = 0
		sprite.flip_v = false # Use the left/right sprite when made (temporary)
	elif dir_x < 0:
		rotation_degrees = 180
		sprite.flip_v = true
	
	if dir_y > 0:
		rotation_degrees = 90
	elif  dir_y < 0:
		rotation_degrees = 270
