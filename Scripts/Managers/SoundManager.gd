class_name SoundManager
extends Node

@export var sfx_audio1: AudioStreamPlayer
@export var sfx_audio2: AudioStreamPlayer
@export var sfx_audio3: AudioStreamPlayer

@export var music_audio: AudioStreamPlayer

@export_subgroup("Sounds")
@export var fire_sound: AudioStream
@export var water_sound: AudioStream
@export var earth_sound: AudioStream
@export var air_sound: AudioStream

@export_subgroup("Music")
@export var menu_music: AudioStream
@export var level_music: AudioStream

@export_subgroup("Narative")
@export var intro_sound: AudioStream
@export var outro_sound: AudioStream

func play_sound(sound: AudioStream):
	if !sfx_audio1.playing:
		sfx_audio1.stream = sound
		sfx_audio1.play()
	if !sfx_audio2.playing:
		sfx_audio2.stream = sound
		sfx_audio2.play()
	if sfx_audio3.playing:
		sfx_audio3.stream = sound
		sfx_audio3.play()

func play_music(music):
	music_audio.stop()
	music_audio.stream = music
	music_audio.play()

func play_intro():
	sfx_audio3.stop()
	sfx_audio3.stream = intro_sound
	sfx_audio3.play()
