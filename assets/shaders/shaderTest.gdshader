shader_type canvas_item;

uniform float wave_strength = 6.0;
uniform float wave_speed = 1.5;
uniform float wave_frequency = 12.0;

uniform vec4 water_color : source_color = vec4(0.1, 0.4, 0.8, 1.0);
uniform float highlight_strength = 0.15;

void fragment() {
    vec2 uv = UV;

    // Time-based wave motion
    float wave = sin((uv.x + TIME * wave_speed) * wave_frequency) *
                 cos((uv.y + TIME * wave_speed) * wave_frequency);

    // Distort UVs
    uv.y += wave * wave_strength * 0.001;

    // Base color
    vec4 color = water_color;

    // Fake light shimmer
    float highlight = smoothstep(0.4, 1.0, wave);
    color.rgb += highlight * highlight_strength;

    COLOR = color;
}
