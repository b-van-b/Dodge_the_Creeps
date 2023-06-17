extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	

func _on_mob_timer_timeout():
	# Create new mob instance
	var mob = mob_scene.instantiate()
	
	# Choose random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Rotate mob perpendicular to path
	var direction = mob_spawn_location.rotation + PI/2
	
	# Set mob start position
	mob.position = mob_spawn_location.position
	
	# Randomize direction slightly
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	# Set random velocity
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn mob in Main scene
	add_child(mob)

