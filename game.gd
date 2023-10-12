extends Node2D

@onready var ball = $Ball
@onready var player1ScoreLabel = $Player1ScoreLabel
@onready var computerScoreLabel = $ComputerScoreLabel
@onready var player1 = $Player1
@onready var computer = $Computer
@onready var gameResponse = $GameResponse
@onready var scoreEffectPlayer = $ScoreEffectPlayer

var player1Score = 0
var computerScore = 0

enum State {
	Reset,
	Score,
	Play,
	Ready,
	GameOver
}

var state = State.Ready

func _physics_process(delta):
	_inputDetection()
	match state:
		State.Play:
			play_state(delta)
		State.Reset:
			reset_state()
		State.Score:
			score_state()
		State.Ready:
			ready_state()
		State.GameOver:
			game_over_state()
			
func _inputDetection():
	if(Input.is_action_pressed("ui_select") && state == State.Ready):
		state = State.Play
	if(Input.is_action_pressed("ui_accept") && state == State.GameOver):
		state = State.Reset

func score_state():
	scoreEffectPlayer.play()
	player1.process_mode = Node.PROCESS_MODE_DISABLED
	computer.process_mode = Node.PROCESS_MODE_DISABLED
	player1ScoreLabel.text = str(player1Score)
	computerScoreLabel.text = str(computerScore)
	if(player1Score == 10 || computerScore == 10):
		state = State.GameOver
	else:
		state = State.Ready

func play_state(delta):
	gameResponse.text = ""
	player1.process_mode = Node.PROCESS_MODE_ALWAYS
	computer.process_mode = Node.PROCESS_MODE_ALWAYS
	ball.move(delta)
	
func reset_state():
	ball.reset()
	player1.reset()
	computer.reset()
	player1ScoreLabel.text = str(0)
	computerScoreLabel.text = str(0)
	player1Score = 0
	computerScore = 0
	state = State.Ready
	
func ready_state():
	if(ball.position != Vector2(640,360)):
		ball.reset()
	gameResponse.text = "Press Space to Start"
		
func game_over_state():
	gameResponse.text = "Game Over\nPress Enter to Reset"

func _on_computer_score_area_score():
	state = State.Score
	computerScore += 1

func _on_player_score_area_score():
	state = State.Score
	player1Score += 1
