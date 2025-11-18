extends CharacterBody2D
class_name Player

@onready var character:AnimatedSprite2D = $Character
var direction:Vector2

func _physics_process(delta: float) -> void:
	if !Input.is_anything_pressed():
		direction = Vector2.ZERO
	move_and_collide(Consts.SPEED * direction * delta)
	if direction != Vector2.ZERO:
		character.play("left")
		if !$sfx.playing: $sfx.play()
	else:
		character.stop()
		$sfx.stop()
	if direction.x < 0:
		character.flip_h = false
	elif direction.x > 0:
		character.flip_h = true

func _unhandled_input(event: InputEvent) -> void:
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
