extends Node
class_name Minigames

const locations:Dictionary = {
	"sweeping": [Vector2(500,300), Vector2(600,300), Vector2(700,300), Vector2(500,400), Vector2(600,400), Vector2(700,400), Vector2(500,500), Vector2(600,500), Vector2(700,500)]
}

const textures:Dictionary = {
	"sweeping": preload("res://icon.svg")
}

const scenes:Dictionary = {
	"sweeping": preload("res://scenes/sweeping.tscn")
}
