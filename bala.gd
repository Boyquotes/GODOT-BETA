extends Area2D

var vel = 500
var direccion = 1


#Agregamos audio de la bala
func _ready():
	$audio_bala.play()

#Creamos funcion para movimiento bala	
func _physics_process(delta):
	var velocidad = Vector2()
	velocidad.x += 1
	if velocidad.length():
		velocidad = velocidad.normalized() * vel
#Agregamos posicion	con base a la direccio, velocidad
	position += direccion * velocidad * delta
	$Sprite.scale.x = direccion
	

#Funcion para cuando la bala sale dela pantalla 
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
#funcion que detecta cuando la bala choca 
func _on_bala_body_entered(body):
	if body.has_method("total_vidas"):
		body.call("total_vidas")
		queue_free()
		
