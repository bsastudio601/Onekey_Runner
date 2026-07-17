extends Node

@onready var spawn_point = $Marker2D
@onready var spawn_timer = $usbtimer

var usb_scene = [
	preload("res://scenes/usbcolcel.tscn"),
	preload("res://scenes/cursor.tscn")
]

func _ready() -> void:
	randomize()
	spawn_timer.timeout.connect(spawn_usb)
	start_spawn_timer()

func spawn_usb() -> void:
	var random_obj = usb_scene.pick_random()
	var usb = random_obj.instantiate()

	usb.position = spawn_point.position
	add_child(usb)

	print("Spawned at:", usb.position)

	start_spawn_timer()

func start_spawn_timer() -> void:
	spawn_timer.wait_time = randf_range(1.5, 3.5)
	spawn_timer.start()
