extends CanvasLayer
class_name UI

var game:Game

func _ready() -> void:
	game = get_parent()
	$pause_menu.visible = false

func _process(delta: float) -> void:
	$time_left.text = str(int(get_parent().time_left/60))+":"+str(int(get_parent().time_left)%60)
	if Input.is_action_just_pressed("pause"):
		$pause_menu.visible = !$pause_menu.visible


func _on_continue_pressed() -> void:
	$pause_menu.visible = false


func _on_give_up_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
