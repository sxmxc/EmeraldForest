extends ParallaxBackground

var speed = 1

func _process(delta):
	for layer in self.get_children():
		layer.motion_offset.x -= speed * layer.motion_scale.x
