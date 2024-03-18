extends Area2D

signal playerIsHit

@export var speed = 180
@export var fireRate = 30
var framesSinceLastFire = fireRate

var screen_size
var bullet = preload("res://bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	#hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	#else:
		#nothing for now
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	if (framesSinceLastFire <= fireRate):
		framesSinceLastFire += 1
		pass
	# Shoot a bullet
	if Input.is_action_pressed("shoot_up"):
		shoot("up")
	if Input.is_action_pressed("shoot_down"):
		shoot("down")
	if Input.is_action_pressed("shoot_left"):
		shoot("left")
	if Input.is_action_pressed("shoot_right"):
		shoot("right")
	
	pass


func _on_body_entered(body):
	#hide()
	playerIsHit.emit()
	
	#$CollisionShape2D.set_deferred("disabled", true)
	pass

func start(pos):
	#position = pos
	#show()
	#$CollisionShape2D.disabled = false
	pass
	
func shoot(direction):
	if (framesSinceLastFire >= fireRate):
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.global_position = $CollisionShape2D.global_position
		if (direction == "up"):
			bulletInstance.velocity = Vector2(0, -1)
		if (direction == "down"):
			bulletInstance.velocity = Vector2(0, 1)
			bulletInstance.rotation = deg_to_rad(180)
		if (direction == "left"):
			bulletInstance.velocity = Vector2(-1, 0)
			bulletInstance.rotation = deg_to_rad(-90)
		if (direction == "right"):
			bulletInstance.velocity = Vector2(1, 0)
			bulletInstance.rotation = deg_to_rad(90)
		framesSinceLastFire = 0
	pass
