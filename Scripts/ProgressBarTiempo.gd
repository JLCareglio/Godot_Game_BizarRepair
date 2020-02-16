extends ProgressBar

var GameOver = preload("res://Scenes/GameOver.tscn")
var en_gameover = false
var is_stop = true

export (float, 0.0, 100.0, .1) var time = 30

func _ready():
	self.max_value = time
	self.value = self.max_value
	
func _process(delta):
	if self.value > 0:
		if !is_stop:
			self.value -= delta
	elif !en_gameover:
		en_gameover = true
		crear_game_over()
		
func crear_game_over():
	$"/root/Persistente/MusicTitle".stop()
	yield(get_tree().create_timer(0.1), "timeout")
	GameOver = GameOver.instance()
	add_child(GameOver)
	get_tree().get_nodes_in_group("GameController")[0].visible = false
