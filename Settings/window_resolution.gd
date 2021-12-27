extends Node
# value: int
#	Index of one of the items in the 'resolution_list'.

# 'resolution_list' should be defined manually. Vector2(width, height).
var resolution_list: Array = [
	Vector2(480, 270),
	Vector2(1024, 576),
	Vector2(1152, 648),
	Vector2(1280, 720),
	Vector2(1366, 768),
	Vector2(1600, 900),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3840, 2160)
]


func main(value: Dictionary) -> void:
	OS.window_size = resolution_list[value["value"]]
	OS.center_window()
