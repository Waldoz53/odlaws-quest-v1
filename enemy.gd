extends RigidBody2D

var speed = 100
var velocity = Vector2(0, 0)
var coinFlip = randi() % 2
var currentLife = 0
var lifespan = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentLife += 1
	if currentLife == lifespan:
		queue_free()
	pass
	
func _physics_process(delta):
	var collisionInfo
	if (coinFlip == 0):
		collisionInfo = move_and_collide(velocity.normalized() * delta * speed)
	else: 
		collisionInfo = move_and_collide(velocity.normalized() * delta * speed * -1)
	pass
