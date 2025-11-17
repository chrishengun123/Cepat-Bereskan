extends Node2D
class_name SortTheTrash

var trash_scene = preload("res://scenes/trash.tscn")
var trash_data:TrashData = load("res://trash_data.gd")
var unsorted:Array = []
var sorted:Array = []

func _ready() -> void:
	for i in range(10):
		var trash:Trash = trash_scene.instantiate()
		trash.type = ["organic", "inorganic"].pick_random()
		trash.texture = trash_data.textures.get(trash.type).pick_random()
		trash.position = Vector2(randf_range(56,1088),576)
