extends Node2D
class_name HideTheMakeup

@onready var bag_space:TileMapLayer = $tilemap/bag_space
var makeup_data = preload("res://scripts/makeup_data.gd")
var makeup:Array
const sides:Array = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
var max_bag_size:Vector2i = Vector2i(6,7)
var makeup_patterns:Array = []

func _ready() -> void:
	start(5)

func start(amount:int):
	bag_space.clear()
	makeup_patterns.clear()
	var possible_patterns:Array = []
	for i in range(bag_space.tile_set.get_patterns_count()):
		possible_patterns.append(bag_space.tile_set.get_pattern(i))
	var possible_coords:Array = []
	for y in max_bag_size.y:
		for x in max_bag_size.x:
			possible_coords.append(Vector2i(x,y))
	for i in range(amount):
		var unchecked_patterns = possible_patterns.duplicate()
		var success:bool = false
		while !success:
			if !unchecked_patterns:
				start(amount)
				return
			var makeup_pattern:TileMapPattern = unchecked_patterns.pop_at(randi()%unchecked_patterns.size())
			if !bag_space.get_used_rect().size:
				bag_space.set_pattern(Vector2i(3,3),makeup_pattern)
				makeup_patterns.append(makeup_pattern)
				success = true
			else:
				var finished = false
				while !finished:
					var unchecked_coords = possible_coords.duplicate()
					var placed = false
					while !placed:
						placed = true
						if !unchecked_coords:
							finished = true
						else:
							var rand_coords = unchecked_coords.pop_at(randi()%unchecked_coords.size())
							for cell_pos in makeup_pattern.get_used_cells():
								if (cell_pos+rand_coords).x >= max_bag_size.x or (cell_pos+rand_coords).y >= max_bag_size.y or bag_space.get_cell_atlas_coords(cell_pos+rand_coords) != Vector2i(-1,-1):
									placed = false
							if !has_connection(makeup_pattern, rand_coords) or produces_hole(makeup_pattern, rand_coords):
								placed = false
							if placed:
								bag_space.set_pattern(rand_coords,makeup_pattern)
								makeup_patterns.append(makeup_pattern)
								finished = true
								success = true
	for pattern:TileMapPattern in makeup_patterns:
		var makeup_sprite:Makeup = Makeup.new()
		makeup_sprite.pattern = pattern.get_used_cells()
		match makeup_sprite.pattern:
			[Vector2i(0,0)]:
				makeup_sprite.type = "beauty blender"
				makeup_sprite.texture = load("res://assets/Makeup Assets/640x BEAUTY BLENDER.png")
			[Vector2i(0,0), Vector2i(1,0)]:
				makeup_sprite.type = "lipstick"
				makeup_sprite.texture = load("res://assets/Makeup Assets/1280x640 LIPSTICK.png")
			[Vector2i(0,0), Vector2i(0,1)]:
				makeup_sprite.type = "foundation"
				makeup_sprite.texture = load("res://assets/Makeup Assets/1280x FOUNDATION.png")
			[Vector2i(0,1), Vector2i(1,0), Vector2i(1,1)]:
				makeup_sprite.type = "eye shadow"
				makeup_sprite.texture = load("res://assets/Makeup Assets/1280x EYESHADOW.png")
			[Vector2i(0,0), Vector2i(0,1), Vector2i(1,0), Vector2i(1,1)]:
				makeup_sprite.type = "powder"
				makeup_sprite.texture = load("res://assets/Makeup Assets/1920x COMPACT POWDER.png")
			[Vector2i(0,0), Vector2i(1,0), Vector2i(2,0), Vector2i(3,0)]:
				makeup_sprite.type = "beauty blender"
				makeup_sprite.texture = load("res://assets/Makeup Assets/640x BEAUTY BLENDER.png")
			[Vector2i(0,0), Vector2i(1,0), Vector2i(1,1), Vector2i(2,0)]:
				makeup_sprite.type = "eyelash curler"
				makeup_sprite.texture = load("res://assets/Makeup Assets/1920x1280 EYELASH CURLER.png")
		makeup_sprite.position = Vector2(randf_range(640,1088), randf_range(64,576))
		makeup_sprite.scale = Vector2.ONE*4.25/100
		add_child(makeup_sprite)
		makeup.append(makeup_sprite)


func has_connection(pattern:TileMapPattern, pos:Vector2i):
	for i in range(pattern.get_used_cells().size()):
		for direction in sides:
			if bag_space.get_cell_atlas_coords(pattern.get_used_cells()[i]+pos+direction) != -Vector2i.ONE:
				return true
	return false

func produces_hole(pattern:TileMapPattern, pos:Vector2i):
	var gen_result:Array = bag_space.get_used_cells()
	var addition:Array = pattern.get_used_cells()
	for i in range(addition.size()):
		addition[i] += pos
	gen_result.append_array(addition)
	for y in range(max_bag_size.y):
		var sequence_checker:int = 0
		for x in range(max_bag_size.x):
			match sequence_checker:
				0:
					if gen_result.has(Vector2i(x,y)):
						sequence_checker += 1
				1:
					if !gen_result.has(Vector2i(x,y)):
						sequence_checker += 1
				2:
					if gen_result.has(Vector2i(x,y)):
						return true
	for x in range(max_bag_size.x):
		var sequence_checker:int = 0
		for y in range(max_bag_size.y):
			match sequence_checker:
				0:
					if gen_result.has(Vector2i(x,y)):
						sequence_checker += 1
				1:
					if !gen_result.has(Vector2i(x,y)):
						sequence_checker += 1
				2:
					if gen_result.has(Vector2i(x,y)):
						return true
	return false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		for item:Makeup in makeup:
			if item.get_rect().has_point(item.to_local(event.position)):
				item.held = true
				break
	elif Input.is_action_just_released("click"):
		for item:Makeup in makeup:
			if item.held:
				item.held = false
				var topleft:Vector2 = item.position - item.texture.get_size()*item.scale/2 + 640*item.scale/2
				var tile_pos:Vector2i = bag_space.local_to_map(bag_space.to_local(topleft))
				item.position = bag_space.to_global(bag_space.map_to_local(tile_pos)) + item.texture.get_size()*item.scale/2 - 640*item.scale/2
