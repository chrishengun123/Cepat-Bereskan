extends CanvasLayer
class_name UI

var game:Game
var dialogue_data:DialogueData = DialogueData.new()
var dialogue:Array = []
var dialogue_index:int = 0

func _ready() -> void:
	game = get_parent()

func _process(delta: float) -> void:
	if dialogue and !$end_screen.visible:
		if Input.is_action_just_pressed("next"):
			if dialogue_index < dialogue.size():
				advance_dialogue()
			else:
				$dialogue_box.visible = false
				dialogue = []
				get_tree().paused = false
				if !game.tasks_left:
					get_tree().paused = true
					%end_text.text = "You cleaned the house in time!"
					$end_screen.visible = true
				elif game.time_left <= 0:
					get_tree().paused = true
					%end_text.text = "Game Over"
					$end_screen.visible = true
			$sfx.stream = load("res://assets/Light Click (1).wav")
			$sfx.play()
	else:
		$time_left.text = str(int(get_parent().time_left/60))+":"+str(int(get_parent().time_left)%60)
		if Input.is_action_just_pressed("pause"):
			$pause_menu.visible = !$pause_menu.visible
			$sfx.stream = load("res://assets/Light Click (1).wav")
			$sfx.play()

func start_dialogue(title):
	get_tree().paused = true
	dialogue = dialogue_data.scripts.get(title)
	dialogue_index = 0
	advance_dialogue()

func advance_dialogue():
	%dialogue_text.text = dialogue[dialogue_index]
	$dialogue_box.visible = true
	dialogue_index += 1

func _on_continue_pressed() -> void:
	$pause_menu.visible = false
	$sfx.stream = load("res://assets/Light Click (1).wav")
	$sfx.play()


func _on_give_up_pressed() -> void:
	$sfx.stream = load("res://assets/Heavy Click (1).wav")
	$sfx.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_end_game_pressed() -> void:
	$sfx.stream = load("res://assets/Heavy Click (1).wav")
	$sfx.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
