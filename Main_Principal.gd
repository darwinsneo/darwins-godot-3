extends Node2D
var velocidad = Vector2()
export (float) var gravedad = 400
export (float) var Vel_Movimiento = 120
export (float) var Vel_Salto = 100
var puede_saltar = false
func _ready():
	pass


func _physics_process(delta):
	
	velocidad.y += gravedad * delta
	
	if(Input.is_action_pressed("tecla_a")):
		velocidad.x = -Vel_Movimiento
		if(!get_node("cuerpo_j1/anim_j1").is_playing()):
			get_node("cuerpo_j1/anim_j1").play("guile_caminando")
			get_node("cuerpo_j1/Spr").flip_h = true
	elif(Input.is_action_pressed("tecla_d")):
		if(!get_node("cuerpo_j1/anim_j1").is_playing()):
			get_node("cuerpo_j1/anim_j1").play("guile_caminando")
			get_node("cuerpo_j1/Spr").flip_h = false
		velocidad.x = Vel_Movimiento
	else:
		velocidad.x = 0
		if(puede_saltar):
			get_node("cuerpo_j1/anim_j1").play("guile_idle")


	if(Input.is_action_pressed("tecla_i") && puede_saltar):
		get_node("cuerpo_j1/anim_j1").play("guile_salto")
		velocidad.y = -Vel_Salto
		puede_saltar = false
		
	
	
	var movimiento = velocidad * delta 
	get_node("cuerpo_j1").move_and_slide(movimiento)
	
	if(get_node("cuerpo_j1").get_slide_collision(get_node("cuerpo_j1").get_slide_count()-1) != null):
		var ob_colisionado = get_node("cuerpo_j1").get_slide_collision(get_node("cuerpo_j1").get_slide_count()-1).collider
		if(ob_colisionado.is_in_group("suelo")):
			if(puede_saltar == false):
				puede_saltar = true
				get_node("cuerpo_j1/anim_j1").stop()
			
	
	

