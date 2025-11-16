extends Node2D
class_name Game

@onready var player:Player = $Player
@onready var ui:UI = $ui
var tasks = preload("res://scenes/task.tscn")
var minigames:Minigames = Minigames.new()
var time_left:float = 10**10
#tasks_left:Array[Task]
var tasks_left:Array

func _ready() -> void:
	var task_types:Array = minigames.locations.keys()
	var task_locations:Dictionary = minigames.locations.duplicate()
	for i in range(3):
		var task:Task = tasks.instantiate()
		var type = task_types.pick_random()
		var locations:Array = task_locations.get(type).duplicate()
		task.position = locations.pop_at(randi()%locations.size())
		task.texture = minigames.textures.get(type)
		task_locations.set(type, locations)
		if locations.size() == 0:
			task_types.erase(type)
		add_child(task)

func _process(delta: float) -> void:
	time_left -= delta
	if time_left <= 0:
		#random ending scene depending on unfinished tasks
		#ui.game_over(tasks_left.pick_random().type)
		pass
	elif tasks_left.size() == 0:
		pass
