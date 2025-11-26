extends CanvasLayer
class_name UI

var game:Game
var in_cutscene:bool = false
@onready var cutscene:Node2D = $cutscene
@onready var cutscene_background:TextureRect = $cutscene/background
@onready var boy:Node2D = $cutscene/boy
@onready var boy_body:Node2D = $cutscene/boy/body
@onready var boy_head:Node2D = $cutscene/boy/head

func _ready() -> void:
	Global.ui = self
	game = get_parent()
	$time_left.max_value = game.time_left

func _process(delta: float) -> void:
	$time_left.value = game.time_left
	$time_left.modulate = Color(1-$time_left.value/$time_left.max_value, $time_left.value/$time_left.max_value, 0)
	cutscene.visible = in_cutscene
	$time_left.visible = !in_cutscene

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		$pause_menu.visible = !$pause_menu.visible
		$sfx.stream = load("res://assets/Light Click (1).wav")
		$sfx.play()

func win():
	%end_text.text = "You cleaned the house in time!"
	$end_screen.visible = true

func lose():
	for child in game.minigame.get_children():
		child.queue_free()
	game.modulation.color = Color.WHITE
	%end_text.text = "Game Over"
	$end_screen.visible = true


func _on_continue_pressed() -> void:
	$pause_menu.visible = false
	$sfx.stream = load("res://assets/Light Click (1).wav")
	$sfx.play()


func _on_give_up_pressed() -> void:
	$sfx.stream = load("res://assets/Heavy Click (1).wav")
	$sfx.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_end_game_pressed() -> void:
	$sfx.stream = load("res://assets/Heavy Click (1).wav")
	$sfx.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
