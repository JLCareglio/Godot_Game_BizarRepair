extends KinematicBody2D

var Target:Position2D

export (float) var speed = 750
export (Texture) var textura_arreglado
export (Texture) var textura_destrozado
export (String) var mensaje
export (bool) var RAereosol_repara
export (bool) var RCinta_repara
export (bool) var RMartillo_repara
export (bool) var RHarryPotter_repara
export (AudioStream) var Audio_Aereosol
export (AudioStream) var Audio_Cinta
export (AudioStream) var Audio_Martillo
export (AudioStream) var Audio_HarryPotter

var textura

var velocity = Vector2()
var borrar_ahora = false

signal en_puntoB

func _ready():
	textura = $Sprite.texture
	
func _physics_process(delta):
	# rotation = velocity.angle()
	if (Target.position - position).length() > 5:
		velocity = (Target.position - position).normalized() * speed
		velocity = move_and_slide(velocity)
	elif(Target == $"../Cinta/PuntoB"):
		emit_signal("en_puntoB")
	elif(Target == $"../Cinta/PuntoC"):
		$Animation.play("Caida_Caja")
		yield($Animation, "animation_finished")
		$"../CintaCajas/Animation".play("MoverCajas")
		remove_child(self)
		queue_free()


func next_objeto():
	borrar_ahora = true
	while yield(self, "en_puntoB"):
		pass
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("Cloud")
	$AudioStreamPlayer2D.play()
	$Sprite.texture = textura
	get_tree().get_nodes_in_group("GameController")[0].reparador_usado(mensaje, (textura==textura_arreglado))
	$EsperaEnPuntoB.start()
	yield($EsperaEnPuntoB, "timeout")
	Target = $"../Cinta/PuntoC"
	get_tree().get_nodes_in_group("GameController")[0].crear_objeto()


func _on_RAerosol_button_down():
	if(!borrar_ahora):
		if RAereosol_repara:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_arreglados += 1
		else:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_destrozados += 1
		textura = textura_arreglado if RAereosol_repara else textura_destrozado
		$AudioStreamPlayer2D.stream = Audio_Aereosol
		next_objeto()


func _on_RCinta_button_down():
	if(!borrar_ahora):
		if RCinta_repara:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_arreglados += 1
		else:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_destrozados += 1
		$AudioStreamPlayer2D.stream = Audio_Cinta
		textura = textura_arreglado if RCinta_repara else textura_destrozado
		next_objeto()


func _on_RMartillo_button_down():
	if(!borrar_ahora):
		if RMartillo_repara:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_arreglados += 1
		else:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_destrozados += 1
		$AudioStreamPlayer2D.stream = Audio_Martillo
		textura = textura_arreglado if RMartillo_repara else textura_destrozado
		next_objeto()


func _on_RHarryPotter_button_down():
	if(!borrar_ahora):
		RHarryPotter_repara = true if rand_range(0,1) <= 0.9 else false
		if RHarryPotter_repara:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_arreglados += 1
		else:
			get_tree().get_nodes_in_group("GameController")[0].contadores.c_destrozados += 1
		$AudioStreamPlayer2D.stream = Audio_HarryPotter
		textura = textura_arreglado if RHarryPotter_repara else textura_destrozado
		next_objeto()
