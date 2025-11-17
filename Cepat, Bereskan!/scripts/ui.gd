extends CanvasLayer
class_name UI

var game:Game
var dialogue_data:DialogueData = DialogueData.new()
var dialogue:Array = []
var dialogue_index:int = 0

func _ready() -> void:
	game = get_parent()
	print(dialogue_data.scripts)

func _process(delta: float) -> void:
	if dialogue:
		if Input.is_action_just_pressed("next"):
			if dialogue_index > dialogue.size():
				$dialogue_box.visible = false
				dialogue = []
				get_tree().paused = false
			else:
				%dialogue_text.text = dialogue[dialogue_index]
				$dialogue_box.visible = true
				dialogue_index += 1
	else:
		$time_left.text = str(int(get_parent().time_left/60))+":"+str(int(get_parent().time_left)%60)
		if Input.is_action_just_pressed("pause"):
			$pause_menu.visible = !$pause_menu.visible

func start_dialogue(title):
	get_tree().paused = true
	dialogue = dialogue_data.scripts.get(title)
	dialogue_index = 0

func _on_continue_pressed() -> void:
	$pause_menu.visible = false


func _on_give_up_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
