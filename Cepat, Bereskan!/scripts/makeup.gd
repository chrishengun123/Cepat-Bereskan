extends Sprite2D
class_name Makeup

var type:String
var pattern:Array
var held:bool = false

func _process(delta: float) -> void:
	if held:
		position = get_global_mouse_position()
