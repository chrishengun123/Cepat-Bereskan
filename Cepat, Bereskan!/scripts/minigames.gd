extends Script
class_name Minigames

const locations:Dictionary = {
	"sweeping": [Vector2(500,300), Vector2(600,300), Vector2(500,400), Vector2(600,400), Vector2(700,400), Vector2(500,500), Vector2(600,500), Vector2(700,500)],
	"mopping": [Vector2(500,300), Vector2(600,300), Vector2(500,400), Vector2(600,400), Vector2(700,400), Vector2(500,500), Vector2(600,500), Vector2(700,500)],
	"scrubbing": [Vector2(896,544), Vector2(240,256)],
	"rice_cooking": [Vector2(700,300)]
}

const textures:Dictionary = {
	"sweeping": [preload("res://assets/DUST 1.png"), preload("res://assets/DUST 2.png")],
	"mopping": [preload("res://assets/SPILLED MESS.png")],
	"scrubbing": [preload("res://icon.svg")],
	"rice_cooking": [preload("res://assets/SK-placeholder.jpg")]
}

const scenes:Dictionary = {
	"sweeping": preload("res://scenes/sweeping.tscn"),
	"mopping": preload("res://scenes/mopping.tscn"),
	"scrubbing": preload("res://scenes/scrubbing.tscn"),
	"rice_cooking": preload("res://scenes/rice_cooking.tscn")
}
