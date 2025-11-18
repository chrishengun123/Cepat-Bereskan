extends Sprite2D
class_name Task

var minigames:Minigames = Minigames.new()
var game:Game
var type:String
var player_touching:bool = false
var task_minigame:Node
var task_started:bool = false

func _ready() -> void:
	material = material.duplicate()
	game = get_parent()

func _process(delta: float) -> void:
	if player_touching and Input.is_action_just_pressed("ui_accept"):
		task_minigame = minigames.scenes.get(type).instantiate()
		game.minigame.add_child(task_minigame)
		task_started = true
	if task_started and !task_minigame:
		game.tasks_left.erase(self)
		if !game.tasks_left:
			DialogueManager.show_dialogue_balloon(Consts.dialogue_script, "good_end")
		queue_free()



func _on_hitbox_body_entered(body: Node2D) -> void:
	player_touching = true
	material.set_shader_parameter("enabled", true)


func _on_hitbox_body_exited(body: Node2D) -> void:
	player_touching = false
	material.set_shader_parameter("enabled", false)
