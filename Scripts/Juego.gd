extends Node2D

onready var objetos = [
	preload("res://Scenes/Objetos/Objeto_Contaminacion.tscn"),
	preload("res://Scenes/Objetos/Objeto_Desastres_Naturales.tscn"),
	preload("res://Scenes/Objetos/Objeto_Filas_De_Cajeros.tscn"),
	preload("res://Scenes/Objetos/Objeto_Inestabilidad_Emocional.tscn"),
	preload("res://Scenes/Objetos/Objeto_Internet.tscn"),
	preload("res://Scenes/Objetos/Objeto_Maltrato_Animal.tscn"),
	preload("res://Scenes/Objetos/Objeto_Musica_En_Transporte_Publico.tscn"),
	preload("res://Scenes/Objetos/Objeto_Paz.tscn"),
	preload("res://Scenes/Objetos/Objeto_Relaciones_Interplanetarias.tscn")
]
var obj_instance

var contadores = {
	"c_arreglados" : 0, "c_destrozados" : 0
}

func _ready():
	$EsperaParaComenzar.start()
	$Maquina/AlarmaMaquina.play()
	yield($EsperaParaComenzar, "timeout")
	$CanvasLayer/ProgressBar.visible = true
	crear_objeto()
	pass
	
func reparador_usado(mensaje_obj, se_arreglo_obj):
	$CanvasLayer/Reparadores/RHarryPotter.visible = true if rand_range(0,1) <= 0.5 else false
	if se_arreglo_obj:
		$CanvasLayer/Texto_Arreglaste.add_color_override("font_color", Color("6afe2e"))
		$CanvasLayer/Texto_Arreglaste.text = "Arreglaste " + mensaje_obj
	else:
		$CanvasLayer/Texto_Arreglaste.add_color_override("font_color", Color("fe2e2e"))
		$CanvasLayer/Texto_Arreglaste.text = "Rompiste " + mensaje_obj
	$CanvasLayer/Texto_Arreglaste/AnimationPlayer.play("Texto_Anim")
	
func crear_objeto():
	if $CanvasLayer/ProgressBar.value > 3:
		randomize()
		obj_instance = objetos[randi() % objetos.size()].instance()
		obj_instance.position = $Cinta/PuntoA.position
		obj_instance.Target = $Cinta/PuntoB
		$CanvasLayer/Reparadores/RAerosol.connect("button_down", obj_instance, "_on_RAerosol_button_down")
		$CanvasLayer/Reparadores/RCinta.connect("button_down", obj_instance, "_on_RCinta_button_down")
		$CanvasLayer/Reparadores/RMartillo.connect("button_down", obj_instance, "_on_RMartillo_button_down")
		$CanvasLayer/Reparadores/RHarryPotter.connect("button_down", obj_instance, "_on_RHarryPotter_button_down")
		add_child(obj_instance)
		$Maquina/Animation.play("Luz_Roja")
