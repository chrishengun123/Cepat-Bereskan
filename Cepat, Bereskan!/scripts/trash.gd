extends Sprite2D
class_name Trash

var type:String
var held:bool = false

func _process(delta: float) -> void:
	if held:
		position = get_global_mouse_position()
