class_name DyingPlayerState
extends PlayerState

var death_timer = 0
var death_timeout = 2

func enter() -> void:
	player.velocity = Vector2.ZERO

func process(delta):
	death_timer += delta
	if death_timer >= death_timeout:
		LevelManagerAutoload.restart_level()
