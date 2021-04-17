extends Area2D


func _on_portal_niveles_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.has_method("cambio_escena"):
		body.call("cambio_escena")
		get_tree().change_escene("res://portal_niveles.tscn")
