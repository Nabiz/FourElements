extends Camera2D

@export var tile_map: TileMapLayer

var free_camera := false
var camera_speed := 1000

func _ready() -> void:
	set_camera_limits()
	call_deferred("follow_player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_home"):
		if free_camera:
			follow_player()
		else:
			freecam()

func _process(delta: float) -> void:
	if free_camera:
		if Input.is_action_pressed("ui_right"):
			position.x += camera_speed * delta
		elif Input.is_action_pressed("ui_left"):
			position.x -= camera_speed * delta
		
		position.x = clamp(position.x, limit_left, limit_right)
		
		if Input.is_action_pressed("ui_up"):
			position.y -= camera_speed * delta
		elif Input.is_action_pressed("ui_down"):
			position.y += camera_speed * delta
			
		position.y = clamp(position.y, limit_top, limit_bottom)

func follow_player():
	free_camera = false
	reparent(Player.instance)
	position = Vector2.ZERO
	Player.instance.can_move = true

func freecam():
	Player.instance.can_move = false
	reparent(Player.instance.get_parent())
	free_camera = true

func set_camera_limits() -> void:
	if tile_map:
		var rect = tile_map.get_used_rect()
		limit_left = rect.position.x * 64
		limit_top = rect.position.y * 64 + 16
		limit_right = (rect.position.x + rect.size.x) * 64
		limit_bottom = (rect.position.y + rect.size.y) * 64 + 16
		
