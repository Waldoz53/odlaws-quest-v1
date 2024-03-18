extends Node

var lives = 3
var currentGhostTimer = 0
var ghostTimer = 60
var ghostSpawnIncreaseTimer = 0
var ghostSpawn = 1
var ghost = preload("res://enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentGhostTimer += 1
	ghostSpawnIncreaseTimer += 1
	if (currentGhostTimer == ghostTimer):
		for n in ghostSpawn:
			var ghostInstance = ghost.instantiate()
			add_child(ghostInstance)
			ghostInstance.position.x = (randi() % 1280)
			ghostInstance.position.y = (randi() % 720)
			ghostInstance.velocity.x = (randi() % 25)
			ghostInstance.velocity.y = (randi() % 25)
			currentGhostTimer = 0
			
	if (ghostSpawnIncreaseTimer == 600):
		ghostSpawnIncreaseTimer = 0
		ghostSpawn += 1
	pass
