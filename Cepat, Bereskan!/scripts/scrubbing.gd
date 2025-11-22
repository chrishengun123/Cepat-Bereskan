extends Node2D

var mashes_left:int = 20

func _ready() -> void:
	$mashes.text = str(mashes_left)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		mashes_left -= 1
		$mashes.text = str(mashes_left)
		if mashes_left == 0:
			queue_free()
