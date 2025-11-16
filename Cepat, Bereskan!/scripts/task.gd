extends Sprite2D
class_name Task

var minigames:Minigames = Minigames.new()
var type:String
var player_touching:bool = false

func _ready() -> void:
	material = material.duplicate()

func _process(delta: float) -> void:
	if player_touching and Input.is_action_just_pressed("ui_accept"):
		get_parent().player.add_child(minigames.data.get(type))


func _on_hitbox_body_entered(body: Node2D) -> void:
	player_touching = true
	material.set_shader_parameter("enabled", true)


func _on_hitbox_body_exited(body: Node2D) -> void:
	player_touching = false
	material.set_shader_parameter("enabled", false)
