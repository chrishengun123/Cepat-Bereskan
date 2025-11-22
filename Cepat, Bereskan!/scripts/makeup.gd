extends Sprite2D
class_name Makeup

var type:String
var pattern:Array
var held:bool = false

func _process(delta: float) -> void:
	if held:
		position = get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and get_rect().has_point(to_local(event.position)):
		held = true
	elif Input.is_action_just_released("click"):
		held = false
