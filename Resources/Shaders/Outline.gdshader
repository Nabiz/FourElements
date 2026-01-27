shader_type canvas_item;

// --- PARAMETRY ---
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float width : hint_range(0.0, 10.0) = 2.0;
uniform float smoothness : hint_range(0.0, 1.0) = 0.5; // Kontrola antyaliasingu
uniform bool animated = false; // Czy obrys ma pulsować?

void fragment() {
	// Pobieramy rozmiar piksela tekstury
	vec2 size = TEXTURE_PIXEL_SIZE;
	
	// Pobieramy kolor oryginalnego piksela
	vec4 sprite_color = texture(TEXTURE, UV);
	
	// Zmienna do przechowywania "siły" obrysu (maksymalna znaleziona alfa)
	float max_alpha = 0.0;
	
	// Dynamiczna szerokość (jeśli chcesz animację)
	float current_width = width;
	if (animated) {
		current_width *= (0.8 + sin(TIME * 5.0) * 0.2);
	}

	// PRZESZUKIWANIE SĄSIADÓW (Technika kołowa dla gładkości)
	// Sprawdzamy 8 kierunków wokół piksela (można dodać więcej dla ultra-gładkości)
	for (float x = -1.0; x <= 1.0; x += 1.0) {
		for (float y = -1.0; y <= 1.0; y += 1.0) {
			if (x == 0.0 && y == 0.0) continue;
			
			// Kierunek przesunięcia
			vec2 direction = normalize(vec2(x, y));
			
			// Próbkujemy alfę w danym kierunku na dystansie 'width'
			float sampled_alpha = texture(TEXTURE, UV + direction * size * current_width).a;
			
			// Zbieramy najwyższą wartość
			max_alpha = max(max_alpha, sampled_alpha);
		}
	}

	// --- MAGIA ANTYALIASINGU ---
	// Używamy smoothstep, aby wygładzić przejście między sprite'em a obrysem.
	// Pozwala to uniknąć spikselowanych schodków.
	float outline_final = smoothstep(sprite_color.a, sprite_color.a + smoothness, max_alpha);
	
	// Składamy finalny kolor
	// Najpierw rysujemy obrys, a na nim (mix) kładziemy oryginalny sprite.
	vec3 final_rgb = mix(outline_color.rgb, sprite_color.rgb, sprite_color.a);
	float final_a = max(max_alpha, sprite_color.a);

	COLOR = vec4(final_rgb, final_a);
}