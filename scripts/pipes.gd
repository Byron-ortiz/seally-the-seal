extends Area2D
var speed = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("pipe exited")
	queue_free()


func set_size(real_size: Vector2) -> void:
	# ensure the size is at least 1.0 to avoid issues with zero or negative sizes
	var clamped_size := Vector2(maxf(real_size.x, 1.0), maxf(real_size.y, 1.0))
	# adjust the sprite and collision shape sizes based on the new size
	var sprite_texture: Texture2D = $Sprite2D.texture
	if sprite_texture == null:
		return
	var texture_size: Vector2 = sprite_texture.get_size()

	# preserve the original sign of the scale to allow for flipping
	var sprite_sign := Vector2(signf($Sprite2D.scale.x), signf($Sprite2D.scale.y))
	# only scale if the texture size is valid to avoid division by zero
	if texture_size.x > 0.0 and texture_size.y > 0.0:
		# calculate the new scale based on the clamped size and original texture size
		$Sprite2D.scale = Vector2(
			clamped_size.x / texture_size.x,
			clamped_size.y / texture_size.y
		) * sprite_sign

	if $CollisionShape2D.shape is RectangleShape2D:
		# duplicate the shape to avoid modifying the original resource
		$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
		var rectangle_shape := $CollisionShape2D.shape as RectangleShape2D
		rectangle_shape.size = clamped_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta
