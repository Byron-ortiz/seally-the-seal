extends Node

@export var mob_scene : PackedScene 

var rand_dim_x : int = 20
var rand_dim_y : int = 80
var base_pipe_size : Vector2 = Vector2(50, 250)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()

func spawn_pipe(spawn_position: Vector2) -> void:
	print("spawn pipe")
	var pipe = mob_scene.instantiate()
	pipe.position = spawn_position
	var y_offset : float = randf_range(-rand_dim_y, rand_dim_y)
	var x_offset : float = randf_range(-rand_dim_x, rand_dim_x)
	pipe.set_size(base_pipe_size + Vector2(x_offset, y_offset))
	add_child(pipe)

# function that spawn mobs
func _on_spawn_timer_timeout():
	var start_pipe_position_ceil = $PipeSpawnerCeil.position
	spawn_pipe(start_pipe_position_ceil)
	var start_pipe_position_floor = $PipeSpawnerFloor.position
	spawn_pipe(start_pipe_position_floor)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
