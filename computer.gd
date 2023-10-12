extends CharacterBody2D

var startingPosition = Vector2.ZERO
const SPEED = 450.0

@onready var ball = get_node("../Ball")

func _ready():
	startingPosition = self.position

func reset():
	self.position = startingPosition

func _physics_process(delta):
	if ball.global_position.y < position.y && ball.global_position.x > 900:
		position.y -= SPEED * delta
	elif ball.global_position.y > position.y && ball.global_position.x > 900:
		position.y += SPEED * delta
	
