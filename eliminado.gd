extends Area2D




func _on_eliminado_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.has_method("eliminado"):
		body.call("eliminado")
		get_tree().change_scene("res://menu_principal.tscn") 
		
