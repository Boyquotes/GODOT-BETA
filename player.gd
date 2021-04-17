extends KinematicBody2D

#Definimos funciones de velocidad y direccion
var gravedad = 350
var vel_hor = 350
var vel_vert = -300
var velocidad = Vector2()
var derecha = false
var izquierda = false
var saltar = false 
var home
var vida = 5
var balazo = true
var bala = preload("res://bala.tscn")

#Creamos funcion para labarra de vida
func _ready():
	$CanvasLayer/barra_vida.max_value = vida 
	mostrar_vidas(vida)

#Cree funcion para la gravedad
func _physics_process(delta):
	velocidad.y += gravedad * delta
#condicionamos las animaciones a partir de la direccion	
	if derecha:
		velocidad.x = vel_hor
		$AnimatedSprite.animation = "corriendo"
		$AnimatedSprite.scala.x = 1 
	elif izquierda:
		velocidad.x = -vel_hor
		$AnimatedSprite.animation = "corriendo"
		$animatedSprite.scale.x = -1
	else:
		if saltar:
			$AnimatedSprite.animation = "salto"
			velocidad.x = 0
		else:
			velocidad.x = 0
			$animationSprite.animation = "frente"
		
	move_and_slide(velocidad, Vector2(0, -1))
	
	#Condicionamos funcion para el salto 
	if is_on_floor() and saltar:
		velocidad.y = vel_vert
				

#Definimos las conecciones del touch, con los botones y las acciones que realizaran
#Boton derecho
func _on_Boton_derecha_pressed():
	derecha = true

func _on_Boton_derecha_released():
	derecha = false


#Boton izquierdo	
func _on_Boton_izquierda_pressed():
	izquierda = true

func _on_Boton_izquierda_released():
	izquierda = true


#Boton de salto
func _on_Boton_saltar_pressed():
	saltar = true

func _on_Boton_saltar_released():
	saltar = false
	
	
#Conexion del boton home con el menu
func _on_boton_home_pressed():
	home = get_tree().change_scene("res://menu_principal.tscn")
	

#Creamos funcion que muestra la vida
func mostrar_vidas(text):
	$CanvasLayer/Numero_vida.text = str(text)
	$CanvasLayer/Barra_vida.value = text

#Creamos otra funcion para ve el total de vidas	
func total_vidas():
	if vida > 1:
		vida -= 1 
		mostrar_vidas(vida)
	else:
		vida -= 1
		mostrar_vidas(vida)
		muerte()
		
#Creamos funcion para morir
func muerte():
	get_tree().call_group("enemigos", "jugador_muerto")
	$Camera2D.current = false
	queue_free()
		
#Funcion para cuando el jugador salga de la pantalla
func _on_VisibilityNotifier2D_screen_exited():
	if position.y > 600:
		muerte()

func disparar():
	if balazo:
		var new_bala = bala.instance()
		get_parent().add_child(new_bala)
		new_bala.position = $AnimatedSprite/posicion_bala.global_position
		new_bala.dire = $AnimatedSprite.scala.x 
		balazo = false
		yield(get_tree().create_timer(0.5), "timeout")
		balazo = true
		

func _on_Boton_disparar_pressed():
	disparar()
	
func nivel_completo():
	hide()



