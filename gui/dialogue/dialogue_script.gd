extends Control

var container = self

func _ready():
	resize()
	get_tree().get_root().connect("size_changed", self, "resize")
	
func resize():
	"""
	Resizes the dialogue box to bottom center on container size change
	"""
	var pos = OS.window_size
	container.rect_position.x = (pos.x / 2) - 500
	container.rect_position.y = pos.y - 225
