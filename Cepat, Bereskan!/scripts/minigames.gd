extends Script
class_name Minigames

const locations:Dictionary = {
	"sweeping": [Vector2(280,120), Vector2(280,180), Vector2(280,240), Vector2(340,240), Vector2(390,240)],
	"mopping": [Vector2(280,120), Vector2(280,180), Vector2(280,240), Vector2(340,240), Vector2(390,240)],
	"scrubbing": [Vector2(640,245)],
	"rice_cooking": [Vector2(600,240)],
	"hide_the_makeup": [Vector2(80,200)],
	"sort_the_trash": [Vector2(650,340)]
}

const textures:Dictionary = {
	"sweeping": [preload("res://assets/Sweeping Assets/DUST 1.png"), preload("res://assets/Sweeping Assets/DUST 2.png")],
	"mopping": [preload("res://assets/Mopping Assets/SPILLED MESS.png")],
	"scrubbing": [preload("res://assets/SK-placeholder.jpg")],
	"rice_cooking": [preload("res://assets/SK-placeholder.jpg")],
	"hide_the_makeup": [preload("res://assets/SK-placeholder.jpg")],
	"sort_the_trash": [preload("res://assets/SK-placeholder.jpg")]
}

const scenes:Dictionary = {
	"sweeping": preload("res://scenes/sweeping.tscn"),
	"mopping": preload("res://scenes/mopping.tscn"),
	"scrubbing": preload("res://scenes/scrubbing.tscn"),
	"rice_cooking": preload("res://scenes/rice_cooking.tscn"),
	"hide_the_makeup": preload("res://scenes/hide_the_makeup.tscn"),
	"sort_the_trash": preload("res://scenes/sort_the_trash.tscn")
}
