extends CanvasLayer
class_name UI

var game:Game
@onready var cutscene:Node2D = $cutscene
@onready var dialogue_background:TextureRect = $cutscene/background
@onready var boy:Node2D = $cutscene/boy
@onready var boy_body:Node2D = $cutscene/boy/body
@onready var boy_head:Node2D = $cutscene/boy/head

func _ready() -> void:
	Global.ui = self
	game = get_parent()

func _process(delta: float) -> void:
	$time_left.text = str(int((get_parent().time_left+1)/60))+":"+str(ceili(get_parent().time_left)%60)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		$pause_menu.visible = !$pause_menu.visible
		$sfx.stream = load("res://assets/Light Click (1).wav")
		$sfx.play()

func win():
	%end_text.text = "You cleaned the house in time!"
	$end_screen.visible = true

func lose():
	%end_text.text = "Game Over"
	$end_screen.visible = true


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
