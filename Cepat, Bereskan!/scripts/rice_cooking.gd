extends Node

var flow_rate:float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$progress.value += flow_rate
	if abs($progress.value-$progress.max_value) <= 2 and flow_rate == 0:
		queue_free()
	if $progress.value-$progress.max_value > 1:
		$progress.value = 0

func _unhandled_input(event: InputEvent) -> void:
	flow_rate += Input.get_axis("ui_left", "ui_right") * 0.01
	flow_rate = clamp(flow_rate, 0, 10)
