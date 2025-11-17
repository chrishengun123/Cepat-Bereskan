extends Node
class_name Minigames

const locations:Dictionary = {
	"sweeping": [Vector2(500,300), Vector2(600,300), Vector2(700,300), Vector2(500,400), Vector2(600,400), Vector2(700,400), Vector2(500,500), Vector2(600,500), Vector2(700,500)]
}

const textures:Dictionary = {
	"sweeping": [preload("res://assets/DUST 1.png"), preload("res://assets/DUST 2.png"), preload("res://assets/DUST 3.png"), preload("res://assets/DUST 4.png"), preload("res://assets/DUST 5.png")]
}

const scenes:Dictionary = {
	"sweeping": preload("res://scenes/sweeping.tscn")
}
