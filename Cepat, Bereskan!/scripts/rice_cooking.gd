extends Node

var flow_rate:float
var water_image : Image
var water_path : String = "res://assets/water_temp_128x128.png"

@onready var water_sprite: Sprite2D = $inner_bowl/Area2D/water
@onready var timer = $Timer

func _ready() -> void:
	_prepare_images()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$progress.value += flow_rate
	#if abs($progress.value-$progress.max_value) <= 2 and flow_rate == 0:
		#queue_free()
	#if $progress.value-$progress.max_value > 1:
		#$progress.value = 0
	if Input.is_key_pressed(KEY_SPACE):
		$inner_bowl/Area2D.position.y -= 15 * delta
	if ($inner_bowl/Area2D/water_collision/WaterWarning.text == "Full !!") and not Input.is_key_pressed(KEY_SPACE):
		queue_free()

#func _unhandled_input(event: InputEvent) -> void:
	#flow_rate += Input.get_axis("ui_left", "ui_right") * 0.01
	#flow_rate = clamp(flow_rate, 0, 10)

func _prepare_images() -> void:
	#pass
	water_image = Image.new()
	water_image.load(water_path)
	
	var target_size = Vector2i(128, 128)   # make sure the size is not too big/small
	if water_image.get_size() != target_size:
		water_image.resize(target_size.x, target_size.y, Image.INTERPOLATE_NEAREST)
		
	var water_texture = ImageTexture.create_from_image(water_image)
	water_sprite.texture = water_texture

func _on_enough_barrier_area_entered(area: Area2D) -> void:
	if area == $inner_bowl/Area2D:
		$inner_bowl/Area2D/water_collision/WaterWarning.text = "Full !!"

func _on_enough_barrier_area_exited(area: Area2D) -> void:
	if area == $inner_bowl/Area2D:
		$inner_bowl/Area2D/water_collision/WaterWarning.text = "Too Much !!"
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
