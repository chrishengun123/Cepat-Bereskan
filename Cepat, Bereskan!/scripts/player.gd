extends CharacterBody2D
class_name Player

@onready var character:AnimatedSprite2D = $Character

func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	move_and_collide(Consts.SPEED * direction * delta)

	rotation(direction)

func rotation(direction:Vector2) -> void:
	if direction.x > 0:
		rotation_degrees = 0
		character.flip_v = false # Use the left/right sprite when made (temporary)
	elif direction.x < 0:
		rotation_degrees = 180
		character.flip_v = true
	
	if direction.y > 0:
		rotation_degrees = 90
	elif  direction.y < 0:
		rotation_degrees = 270
