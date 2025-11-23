extends Node2D
class_name SortTheTrash

var trash_data = preload("res://scripts/trash_data.gd")
var unsorted:Array = []
var sorted:Array = []

func _ready() -> void:
	for i in range(10):
		var trash:Trash = Trash.new()
		trash.type = ["organic", "inorganic"].pick_random()
		trash.texture = trash_data.textures.get(trash.type).pick_random()
		trash.position = Vector2(randf_range(56,1088),576)
		unsorted.append(trash)
		add_child(trash)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		for trash:Trash in unsorted:
			if trash.get_rect().has_point(to_local(event.position)):
				trash.held = true
	elif Input.is_action_just_released("click"):
		for trash:Trash in unsorted:
			trash.held = false
