extends StaticBody2D

var speed := 50.0

func _process(delta):
	position.x -= speed * delta

	if position.x < -180:
		queue_free()
