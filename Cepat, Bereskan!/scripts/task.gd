extends Sprite2D
class_name Task

const minigames = preload("res://scripts/minigames.gd")
var game:Game
var type:String
var task_minigame:Node
var task_started:bool = false

func _ready() -> void:
	material = material.duplicate()
	game = get_parent()

func _process(delta: float) -> void:
	if task_started and !task_minigame and game.time_left > 0:
		match type:
			"sort_the_trash":
				var clean_trash:Sprite2D = Sprite2D.new()
				clean_trash.texture = load("res://icon.svg")
				clean_trash.position = position
				clean_trash.scale = scale
				game.add_child(clean_trash)
		game.tasks_left.erase(self)
		if !game.tasks_left:
			DialogueManager.show_dialogue_balloon(Consts.dialogue_script, "good_end")
		queue_free()
