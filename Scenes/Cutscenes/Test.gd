extends CanvasLayer

func _ready() -> void:
  # Creates a new DialogNode instance
	var dialog_node = $DialogBubble
	dialog_node.visible = true
  # Show an string. BBCode works too!
	dialog_node.show_text("Hello world!")
