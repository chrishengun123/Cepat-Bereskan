extends Node2D
class_name Game

@onready var player:Player = $Player
@onready var ui:UI = $ui
@onready var minigame = $minigame
@onready var modulation:CanvasModulate = $modulation
@onready var bgm:AudioStreamPlayer = $bgm
var tasks = preload("res://scenes/task.tscn")
var minigames = preload("res://scripts/minigames.gd")
var time_left:float = 120
var tasks_left:Array = []
var tasks_touched:Array = []

func _ready() -> void:
	Global.game = self
	player.task_collider.area_entered.connect(_task_detect)
	player.task_collider.area_exited.connect(_task_undetect)
	var task_types:Array = minigames.locations.duplicate().keys()
	var task_locations:Dictionary = minigames.locations.duplicate()
	for i in range(7):
		var task:Task = tasks.instantiate()
		var type = task_types.pick_random()
		var locations:Array = task_locations.get(type).duplicate()
		task.position = locations.pop_at(randi()%locations.size())
		task_locations.set(type, locations)
		for j in range(task_locations.size()):
			var locations_update:Array = task_locations.get(task_locations.keys()[j]).duplicate()
			locations_update.erase(task.position)
			task_locations.set(task_locations.keys()[j], locations_update)
		var k = 0
		while k < task_locations.size():
			if task_locations.get(task_locations.keys()[k]) == []:
				task_locations.erase(task_locations.keys()[k])
				task_types = task_locations.keys()
			else:
				k += 1
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
		DialogueManager.show_dialogue_balloon(Consts.dialogue_script, "bad_end_"+tasks_left.pick_random().type)
		get_tree().paused = true
	if $minigame.get_child_count():
		player.process_mode = Node.PROCESS_MODE_DISABLED
		modulation.color = Color.DARK_GRAY
	else:
		player.process_mode = Node.PROCESS_MODE_INHERIT
		modulation.color = Color.WHITE

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if tasks_touched:
			var task:Task = tasks_touched[0]
			task.task_minigame = minigames.scenes.get(task.type).instantiate()
			minigame.add_child(task.task_minigame)
			task.task_started = true

func _on_bgm_finished() -> void:
	$bgm.play()

func _task_detect(area: Area2D):
	var task:Task = area.get_parent()
	tasks_touched.append(task)
	task.material.set_shader_parameter("enabled", true)

func _task_undetect(area: Area2D):
	var task:Task = area.get_parent()
	tasks_touched.erase(task)
	task.material.set_shader_parameter("enabled", false)
