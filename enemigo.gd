extends KinematicBody2D

#declaramos variables de velocidad, gravedad, posicion, vida del enemigo
var vel_hor = 150
var gravedad = 350
var velocidad = Vector2()
var posicion_enemigo = Vector2()
var vida_enemigo = 3
var bala = preload("res://bala.tscn")
var dis_timer


#Creamos funcion para la vida del enemigo
func _ready():
	$AnimatedSprite.scala.x = -1
	$barra_vida.max_value = vida_enemigo
	mostrar_vidas(vida_enemigo)
	set_physics_process(false)
	dis_timer = Timer.new
	add_child(dis_timer)
	dis_timer.set_autostart(true)
	dis_timer.set_wait_timer(1.2)
	dis_timer.connect("timeout", self, "disparar")

#Agregamos funcion pra la gravedad
#Y funcion para que el enemigo nos siga dependiendo de nuestra posicion
func _physics_process(delta):
	velocidad.y += gravedad * delta
	posicion_enemigo = owner.get_node("jugador").global_position
	if abs(posicion_enemigo.x - global_position.x) > 400:
		$AnimatedSprite.animacion = "corriendo"
		if posicion_enemigo.x > global_position.x:
			velocidad.x = vel_hor
			$AnimatedSprite.scale.x = 1
		elif posicion_enemigo.x < global_position.x:
			velocidad.x = -vel_hor
			$AnimatedSprite.scale.x = -1
	else:
		velocidad.x = 0 
		$AnimatedSprite.animation = "frente"

#Funcion para mostrar nivel de vida		
func mostrar_vidas(text):
	$barra_vida.value = text	
	$numero_vidas.text = str(text)

#Funcion para cuando el enemigo recibe un balazo	
func vidas():
	if vida_enemigo > 1:
		vida_enemigo -= 1
		mostrar_vidas(vida_enemigo)
	else:
		vida_enemigo -= 1
		muerte()

#Funcion para cuando el enemigo muere 
func muerte():
	queue_free()
	
	
	velocidad = move_and_slide(velocidad)

#funcion para cuando el enemigo sale de la pantalla (precipicio alto)
func _on_VisibilityNotifier2D_screen_exited():
	if posicion_enemigo.y > 600:
		muerte()
#Funcion para que el enmigo se active al entrar en pantalla		
func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)
	dis_timer.start()


func disparar():
	var new_bala = bala.instance()
	get_parent().add_child(new_bala)
	new_bala.position = $AnimatedSprite/posicion_bala.global_position
	new_bala.dire = $AnimatedSprite.scale.x

func Jugador_muerto():
	set_physics_process(false)
	dis_timer.stop
