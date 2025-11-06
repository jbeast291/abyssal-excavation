shader_type canvas_item;

uniform vec4 target_color : source_color;
uniform vec4 replacement_color: source_color;
uniform float tolerance = 0.1;

void fragment(){
    vec4 tex_color = texture(TEXTURE, UV);
    
    // check if the pixel color is close to the target color
    float diff = distance(tex_color.rgb, target_color.rgb);
    if (diff < tolerance) {
        COLOR = vec4(replacement_color.rgb, tex_color.a);
    } else {
        COLOR = tex_color;
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
