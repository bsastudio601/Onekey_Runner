extends Button

func _ready():
	pressed.connect(restart_game)

func restart_game():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")
