extends CharacterBody2D

var speed = 500.0
var speedMultiplier = 1.02
var direction = Vector2(0,0)

signal playerScored
signal computerScored

@onready var paddleHitSoundEffect = $PaddleHitSoundEffect
@onready var wallHitSoundEffect = $WallHitSoundEffect

func _ready():
	randomize()
	randomizeDirection()
	
func reset():
	self.position = Vector2(640,360)
	randomizeDirection()
	
func move(delta):
	position += direction * speed * delta

func randomizeDirection():
	var angle = randf_range(0, 2 * PI)
	direction = Vector2(cos(angle), sin(angle))

func _physics_process(delta):
	var collision_info = move_and_collide(direction * delta)
	if collision_info:
		var collided_body = collision_info.get_collider()
		if collided_body.is_in_group("players"):
			direction = direction.bounce(collision_info.get_normal()) * speedMultiplier
			paddleHitSoundEffect.play()
		elif collided_body.is_in_group("wall"):
			direction = direction.bounce(collision_info.get_normal())
			wallHitSoundEffect.play()
		else:
			direction = direction.bounce(collision_info.get_normal())
