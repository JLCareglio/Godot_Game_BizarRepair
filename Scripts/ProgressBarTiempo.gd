extends ProgressBar

var GameOver = preload("res://Scenes/GameOver.tscn")
var en_gameover = false

export (float, 0.0, 100.0, .1) var time = 30

func _ready():
	self.max_value = time
	self.value = self.max_value
	
func _process(delta):
	if self.value > 0:
		self.value -= delta
	elif !en_gameover:
		en_gameover = true
		crear_game_over()
		
func crear_game_over():
	GameOver = GameOver.instance()
	add_child(GameOver)
	get_tree().get_nodes_in_group("GameController")[0].visible = false
