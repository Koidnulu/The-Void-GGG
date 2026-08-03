extends State

class_name platformer_player

@export var player : CharacterBody2D

func physics_update(delta: float) -> void:
	# Add the gravity.
	if player.is_on_floor():
		if player.airbone:
			player.airbone = false;
			# squash, so opposite scale of stretch
			player.character.scale = Vector2(1.3, 0.7)
	else:
		player.velocity += player.get_gravity() * delta * 1.3
		player.airbone = true

	# Handle jump.
	# even if player not on floor, the coyote timer started, so still could jump
	if Input.is_action_just_pressed("jump") and (player.is_on_floor() || !player.coyote_timer.is_stopped()) and !player.velocity.y>0:
		player.velocity.y = player.JUMP_VELOCITY
		# stretch
		player.character.scale = Vector2(0.7, 1.3)
		player.jump.play()
	
	if Input.is_action_just_pressed("dash") and player.can_dash:
		player.dashing = true;
		player.can_dash = false;
		player.dash_timer.start();
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

			
	if direction > 0:
		player.flipping.scale.x = 1
	if direction < 0:
		player.flipping.scale.x = -1

	if direction:
		if player.dashing:
			player.velocity.x = direction * player.DASH_SPEED
		else:	
			player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.ACCEL * player.SPEED)
	
	var was_on_floor = player.is_on_floor()
	
	player.move_and_slide()
	
	 # changed from being on floor to not
	if was_on_floor and !player.is_on_floor():
		player.coyote_timer.start()
		
	update_animations()
	
	# move toward means to change slowly towards, from the stretched x scale to 1
	# (original scale) by a speed of 3 * delta
	player.character.scale.x = move_toward(player.character.scale.x, 1, 1.5* delta)
	player.character.scale.y = move_toward(player.character.scale.y, 1, 1.5 * delta)

func update_animations() -> void:
	if player.attacking:
		return 
	if player.is_on_floor():
		if player.velocity.x == 0:
			player.character.play("idle");
		elif player.dashing == true:
			player.character.play("dash")
		else:
			player.character.play("run");
	else:
		if player.velocity.y < 0:
			player.character.play("jump");
		elif player.dashing == true:
			player.character.play("dash")
		else:
			player.character.play("fall");

	if get_tree().current_scene.name == "puzzle game level 1":
		# the reason why state_machine does not need a reference is because this extends
		# state, and in state, state_machine is declared in the variable
		state_machine.change_state("puzzle_player")

func handle_input(event: InputEvent):
	if event.is_action_pressed("interact"):
		var detector = player.detecting_tilemaps
		var overlapping_bodies = detector.get_overlapping_bodies()
		for body in overlapping_bodies:
			if !body.is_visible_in_tree():
				continue
			else:
				var tilemap_name = body.name
				if body.name == "closed door":
					body.visible = false
					body.process_mode = PROCESS_MODE_DISABLED 
					$"../../../open door".visible = true
					break
				if body.name == "open door":
					Dialogic.end_timeline()
					await Dialogic.timeline_ended
					await BlackFade.fade_in()
					get_tree().change_scene_to_file("res://scenes/puzzle_game_level_1.tscn")
		
		
