shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.5;
uniform vec4 deep_color : source_color = vec4(0.0, 0.4, 0.8, 0.8);
uniform vec4 surface_color : source_color = vec4(0.4, 0.8, 1.0, 1.0);

uniform float wave_amplitude = 0.05;
uniform float wave_frequency = 10.0;
uniform float wave_speed = 1.5;

uniform float surface_thickness : hint_range(0.0, 0.2) = 0.03;
uniform float surface_intensity : hint_range(1.0, 5.0) = 1.0;

void fragment() {
	float current_height = 1.0 - UV.y;

	float wave = sin(UV.x * wave_frequency + TIME * wave_speed) * 0.5;
	wave += cos(UV.x * wave_frequency * 1.5 + TIME * wave_speed * 0.8) * 0.5;
	float surface_level = progress + (wave * wave_amplitude);

	float smoothing = fwidth(current_height) * 1.5;
	float water_mask = smoothstep(surface_level + smoothing, surface_level - smoothing, current_height);
	float foam_mask = smoothstep(surface_level - surface_thickness - smoothing, surface_level - surface_thickness + smoothing, current_height);
	foam_mask *= water_mask;

	vec4 color = vec4(0.0);
	color = mix(color, deep_color, water_mask);
	color.rgb = mix(color.rgb, surface_color.rgb * surface_intensity, foam_mask);
	color.a = clamp(color.a + (foam_mask * surface_color.a), 0.0, 1.0);
	color.a *= water_mask;
	COLOR = color;
}