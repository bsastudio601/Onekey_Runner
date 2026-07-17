extends StaticBody2D

@export var speed := 200.0

func _process(delta):
	position.x -= speed * delta

	if position.x < -180:
		queue_free()
