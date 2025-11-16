extends CanvasLayer
class_name UI

var game:Game

func _ready() -> void:
	game = get_parent()

func _process(delta: float) -> void:
	$time_left.text = str(int(get_parent().time_left/60))+":"+str(int(get_parent().time_left)%60)
