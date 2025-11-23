extends Node
class_name Rice_Cooking

var flow_rate:float
var water_image : Image
var water_path : String = "res://assets/Rice Cooking Assets/Water.png"

@onready var water_sprite: Sprite2D = $inner_bowl/Area2D/water
@onready var timer = $Timer

func _ready() -> void:
	_prepare_images()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		$inner_bowl/Area2D.position.y -= 50 * delta
	if ($inner_bowl/Area2D/water_collision/WaterWarning.text == "Full !!") and not Input.is_key_pressed(KEY_SPACE):
		queue_free()

func _prepare_images() -> void:
	water_image = Image.new()
	water_image.load(water_path)
	
	var target_size = Vector2i(200, 128)   # make sure the size is not too big/small
	if water_image.get_size() != target_size:
		water_image.resize(target_size.x, target_size.y, Image.INTERPOLATE_NEAREST)
		
	var water_texture = ImageTexture.create_from_image(water_image)
	water_sprite.texture = water_texture
	water_sprite.modulate.a = 0.5

func _on_enough_barrier_area_entered(area: Area2D) -> void:
	if area == $inner_bowl/Area2D:
		$inner_bowl/Area2D/water_collision/WaterWarning.text = "Full !!"

func _on_enough_barrier_area_exited(area: Area2D) -> void:
	if area == $inner_bowl/Area2D:
		$inner_bowl/Area2D/water_collision/WaterWarning.text = "Too Much !!"
		set_process(false)
		timer.start()

func _on_timer_timeout() -> void:
	$inner_bowl/Area2D.position.y = 120
	$inner_bowl/Area2D/water_collision/WaterWarning.text = "Keep Going!"
	set_process(true)
