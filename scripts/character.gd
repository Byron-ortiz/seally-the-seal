extends Area2D

@export var speed = 400
var hop_distance : Vector2 = Vector2(0, -40)
var gravity_like : Vector2 = Vector2(0, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func character_movement() -> void:
	var hop = Input.is_action_just_pressed("hop")
	if hop:
		position += hop_distance
		$AnimatedSprite2D.play()
	else:
		position += gravity_like

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	character_movement()
	
