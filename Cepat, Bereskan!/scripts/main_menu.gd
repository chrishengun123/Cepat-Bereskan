extends Node2D
class_name MainMenu


func _on_start_pressed() -> void:
	$sfx.stream = load("res://assets/Heavy Click (1).wav")
	$sfx.play()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	$sfx.stream = load("res://assets/Heavy Click (1).wav")
	$sfx.play()
	get_tree().quit()
