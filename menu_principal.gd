extends Node

var boton_normal = true


func _on_nivel_1_pressed():
	if boton_normal:
		boton_normal = false
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://nivel1.tscn")
