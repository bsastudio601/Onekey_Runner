extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity_flipped = false
var dead = false
@onready var game_over_ui = $"../GameOver"
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var sfx_game_end: AudioStreamPlayer = $sfx_game_end
@onready var bg_music: AudioStreamPlayer = $bg_music
func _ready():
	game_over_ui.hide()
	bg_music.finished.connect(_on_bg_music_finished)
	bg_music.play()
func _on_bg_music_finished() -> void:
	bg_music.play()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if gravity_flipped:
			velocity.y -= get_gravity().y * delta
		else:
			velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_ceiling()):
		jump_sound.play()

		if gravity_flipped:
			velocity.y = -JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY

		if randf() < 0.5:
			gravity_flipped = !gravity_flipped

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("obst"):
			die()

func die():
	if dead:
		return
	dead = true
	game_over_ui.show()
	sfx_game_end.reparent(get_tree().root)
	sfx_game_end.process_mode = Node.PROCESS_MODE_ALWAYS
	sfx_game_end.play()
	sfx_game_end.finished.connect(sfx_game_end.queue_free)
	get_tree().paused = true
