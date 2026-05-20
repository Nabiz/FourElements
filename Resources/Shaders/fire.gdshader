shader_type canvas_item;

// Zmienne, które możesz edytować w Inspektorze
uniform sampler2D noise_tex : repeat_enable; // Ważne: repeat_enable pozwala na zapętlenie
uniform vec4 root_color : source_color = vec4(1.0, 0.75, 0.0, 1.0); // Wnętrze ognia (żółte)
uniform vec4 tip_color : source_color = vec4(0.89, 0.16, 0.0, 1.0); // Krawędzie (czerwone)
uniform float fire_speed = 1.2;

void fragment() {
    vec2 uv = UV;
    
    // 1. Przesuwanie tekstury szumu w górę z upływem czasu
    vec2 noise_uv = uv;
    noise_uv.y -= TIME * fire_speed;
    float noise = texture(noise_tex, noise_uv).r;
    
    // 2. Kształt ognia (szeroki na dole, zwężający się ku górze)
    // Zaczynamy od środka UV (0.5) i wyliczamy odległość
    float dist_x = abs(uv.x - 0.5);
    
    // Im wyżej (mniejsze UV.y), tym węższa maska
    float width_mask = 1.0 - (dist_x * (2.0 + uv.y * 4.0)); 
    float height_mask = 1.0 - uv.y; // Odcięcie górnej krawędzi
    
    // 3. Łączymy matematyczny kształt z szumem
    float fire_intensity = width_mask * height_mask * noise * 2.5;
    
    // 4. Styl Cartoon / Cel-shade (twarde krawędzie)
    // Zamiast płynnego przenikania, funkcja step() tnie wartości "na ostro"
    float outer_flame = step(0.4, fire_intensity);
    float inner_flame = step(0.7, fire_intensity);
    
    // 5. Nakładanie kolorów
    vec4 final_color = mix(vec4(0.0), tip_color, outer_flame); // Zewnętrzny ogień
    final_color = mix(final_color, root_color, inner_flame);   // Wewnętrzny ogień
    
    COLOR = final_color;
}