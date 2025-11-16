extends Node2D
class_name MainMenu


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
