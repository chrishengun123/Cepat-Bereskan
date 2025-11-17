extends Node2D
class_name HideTheMakeup

var makeup_data:MakeupData = MakeupData.new()
var makeup:Array
const sides:Array = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
var placeholder_array:Array = []

var timer = 0
func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		$bag_space.clear()
		start(10)
		timer = 0.5

func start(amount:int):
	for i in range(amount):
		#chooses a random type of makeup
		#makeup.append(makeup_data.data.keys()[randi()%makeup_data.data.size()])
		placeholder_array.append($bag_space.tile_set.get_pattern(randi_range(0,3)))
	#for i in range(makeup.size()):
		#var item = makeup_data.data.get(makeup.pop_at(randi()%makeup.size()))
		#if $bag_space.get_used_rect() == Vector2i(0,0):
			#$bag_space.set_pattern(Vector2i(0,0),null)
		#else:
			#pass
	for i in placeholder_array.size():
		var placeholder_item:TileMapPattern = placeholder_array.pop_at(randi()%placeholder_array.size())
		if $bag_space.get_used_rect().size == Vector2i(0,0):
			$bag_space.set_pattern(Vector2i(0,0),placeholder_item)
		else:
			var placed = false
			while !placed:
				placed = true
				var rand_coords = Vector2i(randi_range(0,10),randi_range(0,10))
				for vec in placeholder_item.get_used_cells():
					if $bag_space.get_cell_atlas_coords(rand_coords+vec) != Vector2i(-1,-1):
						placed = false
				if placed:
					$bag_space.set_pattern(rand_coords,placeholder_item)
