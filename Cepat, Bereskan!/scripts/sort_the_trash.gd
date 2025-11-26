extends Node2D
class_name SortTheTrash

var trash_data = preload("res://scripts/trash_data.gd").new()
var unsorted:Array = []
var sorted:Array = []

@onready var bins: Array = [$OrganicBin, $InorganicBin]

func _ready() -> void:
	for i in range(10):
		var trash:Trash = Trash.new()
		trash.type = ["organic", "inorganic"].pick_random()
		trash.texture = trash_data.textures.get(trash.type).pick_random()
		trash.position = Vector2(randf_range(150,1000),555)
		trash.scale = Vector2(0.12, 0.12)
		trash.rotation = randf_range(0, 2*PI)
		unsorted.append(trash)
		add_child(trash)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		for trash:Trash in unsorted:
			if trash.get_rect().has_point(trash.to_local(event.position)):
				trash.held = true
				break
	elif Input.is_action_just_released("click"):
		for trash:Trash in unsorted:
			if trash.held:
				var timer:Timer = Timer.new()
				add_child(timer)
				timer.start(0.001)
				await timer.timeout
				timer.queue_free()
				if trash:
					trash.held = false
					trash.position.y = 555
					if trash.position.x > 1000 or trash.position.x < 150:
						trash.position.x = randf_range(150,1000)

func _process(float) -> void:
	if len(unsorted) == 0:
		queue_free()

func is_overlapping_organic(trash: Sprite2D, bin: Sprite2D) -> bool:
	var local_point = bin.to_local(trash.global_position)
	return bin.get_rect().has_point(local_point)

func is_overlapping_inorganic(trash: Sprite2D, bin: Sprite2D) -> bool:
	var local_point = bin.to_local(trash.global_position)
	return bin.get_rect().has_point(local_point)


func _on_organic_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("click"):
		for trash:Trash in unsorted:
			if trash.held:
				if trash.type == $OrganicBin.type:
					unsorted.erase(trash)
					trash.queue_free()
				#else:
					#trash.held = false
					#trash.position = Vector2(randf_range(150,1000),555)

func _on_inorganic_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("click"):
		for trash:Trash in unsorted:
			if trash.held:
				if trash.type == $InorganicBin.type:
					unsorted.erase(trash)
					trash.queue_free()
				#else:
					#trash.held = false
					#trash.position = Vector2(randf_range(150,1000),555)
