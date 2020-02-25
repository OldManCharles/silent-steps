extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()

func _physics_process(delta: float) -> void:
	handle_input()

func handle_input():
	move()
	handle_attack()
	look_at_mouse()

func handle_movement_input() -> void:
	# vertical movement
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
	
	# horizontal movement
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)

func look_at_mouse():
	look_at(get_global_mouse_position())

func move():
	handle_movement_input()
	motion = move_and_slide(motion)

func handle_attack():
	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite.play("slash")


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.get_animation() == "slash":
		$AnimatedSprite.play("run")
