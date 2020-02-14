extends Control

func _ready():
	$"/root/Persistente/MusicTitle".play()
	$VideoPlayer.play()

func _on_Button_button_up():
	$VideoPlayer.visible = false
	$Button.visible = false
	$TextureRect.visible = false
	$Tutorial.visible = true

func _on_Button_button_down():
	$AudioStreamPlayer2D.play()
func _on_Buttont1_button_down():
	$AudioStreamPlayer2D.play()
func _on_Buttont2_button_down():
	$AudioStreamPlayer2D.play()
func _on_Buttont3_button_down():
	$AudioStreamPlayer2D.play()

func _on_Buttont1_button_up():
	$Tutorial.visible = false
	$Tutorial2.visible = true


func _on_Buttont2_button_up():
	$Tutorial2.visible = false
	$Tutorial3.visible = true


func _on_Buttont3_button_up():
	$Tutorial3.visible = false
	$Button.visible = true
	$TextureRect.visible = true
	$Tutorial.visible = false
	get_tree().change_scene("res://Scenes/Juego.tscn")


func _on_VideoPlayer_finished():
	$VideoPlayer.visible = false
