extends Area2D



func _on_puerta_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.has_method("nivel_completo"):
		body.call("nivel_completo")
		get_tree().change_scene("res:// menu_principal.tscn") 
