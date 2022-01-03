extends CanvasModulate


func _ready():
	GameClock.connect("morning", self, "_on_morning")
	GameClock.connect("evening", self, "_on_evening")
	GameClock.connect("night", self, "_on_night")
	GameClock.connect("midnight", self, "_on_midnight")
	pass


func _on_morning():
	$AnimationPlayer.play("Morning")
	
func _on_evening():
	$AnimationPlayer.play("Evening")
	
func _on_night():
	$AnimationPlayer.play("Night")
	
func _on_midnight():
	$AnimationPlayer.play("Twilight")
