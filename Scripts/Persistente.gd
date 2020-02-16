extends Node

onready var progress = $CanvasLayer/Progress

var loader
var current_scene

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func load_scene(path): # el juego pide cambiar a este escena
	$MusicBadFinal.stream_paused = true
	$MusicGoodFinal.stream_paused = true
	$MusicTitle.stream_paused = true
	current_scene.queue_free() # dejar de lado la escena vieja
	progress.value = 0
	progress.visible = true
	$CanvasLayer/ColorRect.visible = true
	yield(get_tree().create_timer(0.3), "timeout")
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # chequear errores
		return
	set_process(true)


func _process(time):
	if loader == null:
		#  no hace falta procesar mas
		set_process(false)
		return
		
	var err = loader.poll()

	if err == ERR_FILE_EOF: # la carga termino
		var resource = loader.get_resource()
		loader = null
		set_new_scene(resource)
	elif err == OK:
		update_progress()
	else: # error durante la carga
		loader = null

func update_progress():
	var progress_value = float(loader.get_stage()) / loader.get_stage_count() * 100
	progress.value = progress_value

func set_new_scene(scene_resource):
	progress.value = 100
	yield(get_tree().create_timer(0.3), "timeout")
	$MusicBadFinal.stream_paused = false
	$MusicGoodFinal.stream_paused = false
	$MusicTitle.stream_paused = false
	progress.visible = false
	$CanvasLayer/ColorRect.visible = false
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
