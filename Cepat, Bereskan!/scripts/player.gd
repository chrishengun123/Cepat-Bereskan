extends CharacterBody2D
class_name Player

@onready var character:AnimatedSprite2D = $Character

func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	move_and_collide(Consts.SPEED * direction * delta)
	if direction != Vector2.ZERO:
		character.play("left")
		if !$sfx.playing: $sfx.play()
	else:
		character.stop()
	if direction.x < 0:
		character.flip_h = false
	elif direction.x > 0:
		character.flip_h = true
