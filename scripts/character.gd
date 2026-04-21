extends Area2D

signal character_hit

@export var speed = 200
var hop_distance : Vector2 = Vector2(0, -60)
var gravity_like : Vector2 = Vector2(0, speed)

func character_movement(delta: float) -> void:
	var hop = Input.is_action_just_pressed("hop")
	if hop:
		position += hop_distance
		$AnimatedSprite2D.play()
	else:
		position += gravity_like*delta

func _on_body_entered(_body: Node) -> void:
	hide()
	character_hit.emit()
	# deferred
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	character_movement(delta)
