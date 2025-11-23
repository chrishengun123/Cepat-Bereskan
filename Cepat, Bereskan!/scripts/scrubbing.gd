extends Node2D

var mashes_left:int = 20

func _ready() -> void:
	$mashes.text = str(mashes_left)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		mashes_left -= 1

		if $HandHoldingSponge.rotation == 0:
			$HandHoldingSponge.rotation = -0.9
			$HandHoldingSponge.position = Vector2(545, 380)
			bubble_left()
		else:
			$HandHoldingSponge.rotation = 0.0
			$HandHoldingSponge.position = Vector2(660, 380)
			bubble_right()

		$mashes.text = str(mashes_left)
		if mashes_left == 0:
			queue_free()

func bubble_left():
	var bubble = Sprite2D.new()
	bubble.texture = preload("res://assets/Scrubbing Assets/bubble_translucent_1_32x32.png")
	bubble.position.x = randf_range(470,550)
	bubble.position.y = randf_range(270,330)
	add_child(bubble)
	bubble.scale = Vector2(5, 5)
	var tween = create_tween()
	tween.tween_property(bubble, "scale", Vector2(5.5, 5.5), 0.8)
	tween.tween_callback(func():
		if bubble.scale.x >= 5.5:
			bubble.queue_free()
		)

func bubble_right():
	var bubble = Sprite2D.new()
	bubble.texture = preload("res://assets/Scrubbing Assets/bubble_translucent_1_32x32.png")
	bubble.position.x = randf_range(680,760)
	bubble.position.y = randf_range(270,330)
	add_child(bubble)
	bubble.scale = Vector2(5, 5)
	var tween = create_tween()
	tween.tween_property(bubble, "scale", Vector2(5.5, 5.5), 0.8)
	tween.tween_callback(func():
		if bubble.scale.x >= 5.5:
			bubble.queue_free()
	)
