extends Node2D
class_name Mopping

var mop_sfx: Array = [preload("res://assets/Broom Var. 4.wav")]

var dirt_path: String = "res://assets/SPILLED MESS.png"
var clean_path: String = "res://assets/FLOOR_SPRITE_3-1.jpg"
var brush_radius_px: int = 6
var alpha_threshold: float = 0.05
var target_percent: float = 100.0
var update_texture_every_input: bool = true

@onready var dirt_sprite: Sprite2D = $SpilledMess
@onready var clean_sprite: Sprite2D = $FloorSprite31
@onready var percent_label: Label = $PercentLabel

# Image/Texture
var dirt_image: Image
var mask_image: Image   # R8 mask (0 = clean, 1 = dirt)
var mask_texture: ImageTexture

# Progress
var total_dirt_pixels: int = 0
var cleaned_pixels_count: int = 0


func _ready() -> void:
	_prepare_images_and_mask()
	_assign_mask_to_shader()
	_update_label()

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var global_pos = get_global_mouse_position()
		var tex_pos = _screen_to_texture_coords(global_pos)
		if tex_pos.x != -1:
			apply_brush_to_mask(tex_pos, brush_radius_px)
			if update_texture_every_input:
				update_mask_texture()
			#check_percentage()
			_update_label()
		if !$sfx.playing:
			on_mop_sfx_finished()
	if percent_cleaned() >= target_percent:
		queue_free()

func on_mop_sfx_finished() -> void:
	$sfx.stream = mop_sfx.pick_random()
	$sfx.play()

func _prepare_images_and_mask() -> void:
	dirt_image = Image.new()
	dirt_image.load(dirt_path)
	dirt_image.convert(Image.FORMAT_RGBA8)

	var target_size = Vector2i(80, 80)   # make sure the size is not too big
	if dirt_image.get_size() != target_size:
		dirt_image.resize(target_size.x, target_size.y, Image.INTERPOLATE_NEAREST)
	
	var dirt_texture = ImageTexture.create_from_image(dirt_image)
	dirt_sprite.texture = dirt_texture

	var w = dirt_image.get_width()
	var h = dirt_image.get_height()
	
	mask_image = Image.create(w, h, false, Image.FORMAT_R8)
	mask_image.fill(Color(1,1,1))   # 1 = dirty
	mask_texture = ImageTexture.create_from_image(mask_image)
	
	total_dirt_pixels = 0
	for y in range(h):
		for x in range(w):
			var c: Color = dirt_image.get_pixel(x, y)
			if c.a > alpha_threshold:
				total_dirt_pixels += 1

func _assign_mask_to_shader() -> void:
	dirt_sprite.material.set_shader_parameter("dirt_mask", mask_texture)

func _screen_to_texture_coords(global_pos: Vector2) -> Vector2i:
	var tex = dirt_sprite.texture
	if tex == null:
		return Vector2i(-1, -1)
	
	var w = tex.get_width()
	var h = tex.get_height()

	var local = dirt_sprite.to_local(global_pos)
	
	if dirt_sprite.centered:
		local.x += w * 0.5
		local.y += h * 0.5

	var px = int(local.x)
	var py = int(local.y)

	if px < 0 or py < 0 or px >= w or py >= h:
		return Vector2i(-1, -1)

	return Vector2i(px, py)

func apply_brush_to_mask(center_px: Vector2i, radius_px: int) -> void:
	var w = mask_image.get_width()
	var h = mask_image.get_height()

	var x0: int = max(0, center_px.x - radius_px)
	var y0: int = max(0, center_px.y - radius_px)
	var x1: int = min(w - 1, center_px.x + radius_px)
	var y1: int = min(h - 1, center_px.y + radius_px)

	var r2 = radius_px * radius_px
	
	for y in range(y0, y1 + 1):
		var dy = y - center_px.y
		var dy2 = dy * dy
		for x in range(x0, x1 + 1):
			var dx = x - center_px.x
			if dx*dx + dy2 > r2:
				continue

			var dirt_color = dirt_image.get_pixel(x, y)
			if dirt_color.a <= alpha_threshold:
				continue

			var prev = mask_image.get_pixel(x, y).r
			if prev <= 0.01:
				continue

			mask_image.set_pixel(x, y, Color(0,0,0))
			cleaned_pixels_count += 1

func update_mask_texture() -> void:
	mask_texture.update(mask_image)
	var mat = dirt_sprite.material
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("dirt_mask", mask_texture)

func percent_cleaned() -> float:
	if total_dirt_pixels == 0:
		return 100.0
	return float(cleaned_pixels_count) / float(total_dirt_pixels) * 100.0

func check_percentage() -> void:
	if percent_cleaned() >= target_percent:
		print("SUCCESS %.2f%%" % percent_cleaned())
		set_process(false)
	print("total size of mask: ", total_dirt_pixels, ", cleaned ", cleaned_pixels_count, "(", percent_cleaned(),") percent")

func _update_label() -> void:
	if percent_label:
		percent_label.text = "Cleaned: %.2f%%" % percent_cleaned()
