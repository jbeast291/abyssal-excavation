shader_type canvas_item;
render_mode blend_mix, unshaded;

const int MAX_WAVES = 8;
uniform int wave_count = 4; // 1..MAX_WAVES
uniform float base_height = 6.0;
uniform float base_length = 80.0;
uniform float base_speed = 1.8;
uniform vec4 water_color : source_color = vec4(0.1, 0.4, 0.8, 1.0);

// Adjust these based on your polygon
uniform float top_y = 0.0;      // Y of the top vertices
uniform float bottom_y = -32.0; // Y of the bottom vertices

varying float vertex_alpha;

float rand(float n) {
    return fract(sin(n) * 43758.5453123);
}

void vertex() {
    float original_y = VERTEX.y;

    float x = VERTEX.x;
    float wave = 0.0;

    for (int i = 0; i < MAX_WAVES; i++) {
        if (i >= wave_count) break;

        float fi = float(i);
        float length = base_length / (1.0 + fi * 0.6);
        float speed  = base_speed  * (1.0 + fi * 0.4);
        float height = base_height / (1.0 + fi * 0.8);
        float phase  = rand(fi) * 6.28318;

        wave += sin((x / length) + TIME * speed + phase) * height;
    }

    VERTEX.y += wave;

    // Flip fade so top is opaque, bottom is transparent
    vertex_alpha = clamp((top_y - original_y) / (top_y - bottom_y), 0.0, 1.0);
}

void fragment() {
    COLOR = vec4(water_color.rgb, water_color.a * vertex_alpha);
}
