extends State

class_name puzzle_player

@export var player : CharacterBody2D
	
func physics_update(delta: float):
	if Input.is_action_just_pressed("dash") and player.can_dash:
		player.dashing = true;
		player.can_dash = false;
		player.dash_timer.start();
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

#  vectors, .x represents left and right, .y up and down
	if direction.x > 0:
		player.flipping.scale.x = 1
	if direction.x < 0:
		player.flipping.scale.x = -1
	
	if direction != Vector2.ZERO:
			if player.dashing:
				player.velocity.x = direction.x * player.DASH_SPEED
			else:	
				player.velocity.x = direction.x * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.ACCEL * player.SPEED)
	
	if direction != Vector2.ZERO:
			if player.dashing:
				player.velocity.y = direction.y * player.DASH_SPEED
			else:	
				player.velocity.y = direction.y * player.SPEED
	else:
		player.velocity.y = move_toward(player.velocity.y, 0, player.ACCEL * player.SPEED)
		
	player.move_and_slide()
	update_animations()


func update_animations() -> void:
	if player.attacking:
		return 
	if player.velocity == Vector2.ZERO:
		player.character.play("idle");
	elif player.dashing == true:
		player.character.play("dash")
	else:
		player.character.play("run");

func handle_input(event: InputEvent):
	if event.is_action_pressed("interact"):
		var detector = player.detecting_tilemaps
		var overlapping_bodies = detector.get_overlapping_bodies()
		
		# Get the bounding box of your detector's collision shape
		var collision_shape = detector.get_node("CollisionShape2D")
		var rect = collision_shape.shape.get_rect()
		var global_rect = Rect2(collision_shape.global_position + rect.position, rect.size)

		var closest_key: String = ""
		var shortest_distance: float = INF # Start at infinity so any real distance is shorter

		for body in overlapping_bodies:
			if body is TileMapLayer:
				# this is the boundary box and using top left and bottom right 
				# to form a range and find every tile inside this range
				var top_left = body.local_to_map(body.to_local(global_rect.position))
				var bottom_right = body.local_to_map(body.to_local(global_rect.end))
				
				# Loop through every tile coordinate inside the detector's box
				for x in range(top_left.x, bottom_right.x + 1):
					for y in range(top_left.y, bottom_right.y + 1):
						var grid_cell = Vector2i(x, y)
						var cell_data = body.get_cell_tile_data(grid_cell)
						
						if cell_data:
							var key = cell_data.get_custom_data("dialogue_key")
							if key and key != "":
								# 1. Find the physical world center point of this specific tile
								var tile_local_pos = body.map_to_local(grid_cell)
								var tile_global_pos = body.to_global(tile_local_pos)
								var distance = player.global_position.distance_squared_to(tile_global_pos)
							
								if distance < shortest_distance:
									shortest_distance = distance
									# this is the object closest to player
									closest_key = key
		if closest_key != "":
			InteractionManager.trigger_interaction(closest_key)
