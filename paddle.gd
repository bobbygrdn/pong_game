extends CharacterBody2D

const SPEED = 600.0
var startingPosition = Vector2.ZERO

func _physics_process(delta):

	position.x = 30.0
	var direction = Input.get_axis("ui_down", "ui_up")
	if direction:
		velocity.y = -direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _ready():
	startingPosition = self.position

func reset():
	self.position = startingPosition
