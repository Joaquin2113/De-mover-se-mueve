extends CharacterBody2D

@export var speed: float = 300.0
var tween: Tween

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_key_pressed(KEY_A) or Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_key_pressed(KEY_W) or Input.is_action_pressed("ui_up"):
		direction.y -= 1
		
	direction = direction.normalized()
	
	var current_speed = speed
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed *= 1.6
	
	velocity = direction * current_speed
	move_and_slide()
	
	if direction != Vector2.ZERO:
		if not tween or not tween.is_running():
			tween = create_tween().set_loops()
			tween.tween_property($Sprite2D, "rotation_degrees", 45.0, 0.25)
			tween.tween_property($Sprite2D, "rotation_degrees", -45.0, 0.25)
	else:
		if tween:
			tween.kill()
			tween = null
			$Sprite2D.rotation_degrees = 0.0
