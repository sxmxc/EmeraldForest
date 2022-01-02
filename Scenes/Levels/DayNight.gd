extends CanvasModulate


func _ready():
	GameClock.connect("morning", self, "_on_morning")
	GameClock.connect("noon", self, "_on_noon")
	GameClock.connect("evening", self, "_on_evening")
	GameClock.connect("night", self, "_on_night")
	pass


func _on_morning():
	$AnimationPlayer.play("Morning")
	
func _on_noon():
	$AnimationPlayer.play("Afternoon")
	
func _on_evening():
	$AnimationPlayer.play("Evening")
	
func _on_night():
	$AnimationPlayer.play("Night")
