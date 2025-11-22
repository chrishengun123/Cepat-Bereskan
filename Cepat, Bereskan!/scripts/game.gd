extends Node2D
class_name Game

@onready var player:Player = $Player
@onready var ui:UI = $ui
@onready var minigame = $minigame
@onready var bgm:AudioStreamPlayer = $bgm
var tasks = preload("res://scenes/task.tscn")
var minigames = preload("res://scripts/minigames.gd")
var time_left:float = 240
var tasks_left:Array = []

func _ready() -> void:
	Global.game = self
	var task_types:Array = minigames.locations.keys()
	var task_locations:Dictionary = minigames.locations.duplicate()
	for i in range(task_locations.size()):
		if !task_locations.get(task_locations.keys()[i]):
			task_locations.erase(task_locations.keys()[i])
			task_types = task_locations.keys()
	for i in range(5):
		var task:Task = tasks.instantiate()
		var type = task_types.pick_random()
		var locations:Array = task_locations.get(type)
		task.position = locations[randi()%locations.size()]
		for j in range(task_locations.size()):
			task_locations.get(task_locations.keys()[j]).erase(task.position)
		task.texture = minigames.textures.get(type).pick_random()
		task.type = type
		task_locations.set(type, locations)
		if locations.size() == 0:
			task_types.erase(type)
		add_child(task)
		tasks_left.append(task)
	DialogueManager.show_dialogue_balloon(Consts.dialogue_script, "intro")

func _process(delta: float) -> void:
	if !ui.in_cutscene and tasks_left:
		time_left -= delta
	if time_left <= 0 and tasks_left:
		#random ending scene depending on unfinished tasks
		DialogueManager.show_dialogue_balloon(Consts.dialogue_script, "bad_end_sweeping")
		get_tree().paused = true
	if $minigame.get_child_count():
		player.process_mode = Node.PROCESS_MODE_DISABLED
		$modulation.color = Color.DARK_GRAY
	else:
		player.process_mode = Node.PROCESS_MODE_INHERIT
		$modulation.color = Color.WHITE


func _on_bgm_finished() -> void:
	$bgm.play()
