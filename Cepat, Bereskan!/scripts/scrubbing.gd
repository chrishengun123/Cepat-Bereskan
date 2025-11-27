extends Node2D

var mashes_left:int = 20

func _ready() -> void:
	$mashes.text = str(mashes_left)
	$Dirt.modulate.a = 1
	$HandHoldingSponge.rotation = 0.4

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		mashes_left -= 1
		$Dirt.modulate.a -= 0.06
		$sfx.play()

		if $HandHoldingSponge.rotation > 0:
			$HandHoldingSponge.rotation = -0.5
			$HandHoldingSponge.position = Vector2(500, 340)
			bubble_left()
		elif $HandHoldingSponge.rotation < 0:
			$HandHoldingSponge.rotation = 0.4
			$HandHoldingSponge.position = Vector2(640, 340)
			bubble_right()

		$mashes.text = str(mashes_left)
		if mashes_left == 0:
			queue_free()

func bubble_left():
	var bubble = Sprite2D.new()
	bubble.texture = preload("res://assets/Scrubbing Assets/BUBBLES transparent.png")
	bubble.position.x = randf_range(440,550)
	bubble.position.y = randf_range(250,400)
	add_child(bubble)
	var s = randf_range(2, 2.72)
	bubble.scale = Vector2(s, s)
	var tween = create_tween()
	tween.tween_property(bubble, "scale", Vector2(2.8, 2.8), 0.7)
	tween.tween_callback(func():
		if bubble.scale.x >= 2.72:
			bubble.queue_free()
		)

func bubble_right():
	var bubble = Sprite2D.new()
	bubble.texture = preload("res://assets/Scrubbing Assets/BUBBLES transparent.png")
	bubble.position.x = randf_range(610,720)
	bubble.position.y = randf_range(250,400)
	add_child(bubble)
	var s = randf_range(2, 2.72)
	bubble.scale = Vector2(s, s)
	var tween = create_tween()
	tween.tween_property(bubble, "scale", Vector2(2.8, 2.8), 0.7)
	tween.tween_callback(func():
		if bubble.scale.x >= 2.72:
			bubble.queue_free()
	)
