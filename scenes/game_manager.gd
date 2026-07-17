extends Node2D

@onready var score_lable = $Score_Label
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score += int(delta*100)
	score_lable.text = "Score: " + str(score)
	pass
