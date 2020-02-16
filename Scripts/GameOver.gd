extends Node2D

export (String) var txt_titulo_malo = "Lo Has Hecho Mal"
export (String) var txt_titulo_bueno = "Buen Trabajo!"

onready var txt_finales_malos = [
	"Como decirlo... radioactivo es quedarse corto... tu planeta es tan tóxico que enferma incluso a los planetas de los alrededores. Su luna se terminó derritiendo y emite tanta radiación que pensamos que era un sol.",
	"Por alguna razón las aves armaron una guerra con los peces y todo el resto de seres vivos quedó en medio del fuego cruzado... al final la guerra cesó... pero porque ya no quedaba elemento que pudiera ser usado como arma, en todo caso, todos se extinguieron.",
	"Solo exploto... un dia... de la nada... nose porque.",
	"La inflación de tu mundo esta tan alta que ni vendiendo el alma de todos se puede salir de la pobreza.\nAl final todos murieron porque respirar salía demasiado caro.",
	"Un dia las nubes comenzaron a caerse y desde allí todo fue hacia abajo. Las leyes de la física se alteraron tanto que la gravedad era al revés, y bueno, los seres vivos no sobreviven en el espacio."
]
onready var txt_finales_buenos = [
	"Tu mundo es tan bueno que incluso ganó un premio por tener muchos premios. Todo funciona bien, tanto así que los ríos se volvieron de chocolate y todos tienen derecho a pizza gratis.",
	"Automáticamente a todos les crece una cabellera hasta la cintura y se vuelven musculosos. Debo admitirlo, los animales se ven raros. Pero ellos están felices, así que, qué más da.",
	"Los seres de tu mundo son tan avanzados y utópicos que solo se mueven levitando, y hablan únicamente con la mente.",
	"No tengo idea de que es lo que hiciste, pero todos son tan amables y buenos que cualquiera puede entrar en la casa de cualquiera y es bienvenido. Nadie Roba nada porque entre todos se regalan todo."
]

func _ready():
	var rand
	var puntos = get_tree().get_nodes_in_group("GameController")[0].contadores.c_arreglados - get_tree().get_nodes_in_group("GameController")[0].contadores.c_destrozados
	$CanvasLayer/FinalBueno.visible = false
	$CanvasLayer/FinalMalo.visible = false

	$"/root/Persistente/MusicTitle".stop()
	randomize()
	if puntos > 0:
		$CanvasLayer/txt_titulo_final.text = txt_titulo_bueno
		$CanvasLayer/txt_titulo_final.add_color_override("font_color", Color("6afe2e"))
		rand = randi() % txt_finales_buenos.size()
		$CanvasLayer/txt_finales.text = txt_finales_buenos[rand]
		$CanvasLayer/txt_final_numero.text = "Final " + String(rand+1) + " Conseguido"
		$CanvasLayer/FinalBueno.visible = true
		$"/root/Persistente/MusicGoodFinal".play()
	else:
		$CanvasLayer/txt_titulo_final.text = txt_titulo_malo
		$CanvasLayer/txt_titulo_final.add_color_override("font_color", Color("fe2e2e"))
		rand = randi() % txt_finales_malos.size()
		$CanvasLayer/txt_finales.text = txt_finales_malos[rand]
		$CanvasLayer/txt_final_numero.text = "Final -" + String(rand+1) + " Conseguido"
		$CanvasLayer/FinalMalo.visible = true
		$"/root/Persistente/MusicBadFinal".play()
	$CanvasLayer/txt_puntos.text = String(puntos) + " Puntos"
	$CanvasLayer/txt_puntos.add_color_override("font_color", Color.yellow)
	get_tree().get_nodes_in_group("GameController")[0].visible = false


func _on_ButtonJugar_button_down():
	$CanvasLayer/AudioStreamPlayer.play()

func _on_ButtonMenu_button_down():
	$CanvasLayer/AudioStreamPlayer.play()

func _on_ButtonJugar_button_up():
	$"/root/Persistente/MusicGoodFinal".stop()
	$"/root/Persistente/MusicBadFinal".stop()
	$"/root/Persistente/MusicTitle".play()
	$CanvasLayer/ButtonJugar.visible = false
	$CanvasLayer/ButtonMenu.visible = false
	self.visible = false
	Persistente.load_scene("res://Scenes/Introduccion.tscn")
	
func _on_ButtonMenu_button_up():
	$"/root/Persistente/MusicGoodFinal".stop()
	$"/root/Persistente/MusicBadFinal".stop()
	$"/root/Persistente/MusicTitle".play()
	$CanvasLayer/ButtonJugar.visible = false
	$CanvasLayer/ButtonMenu.visible = false
	self.visible = false
	Persistente.load_scene("res://Scenes/Juego.tscn")


