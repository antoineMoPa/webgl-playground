varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;

uniform float time;

vec3 stars(vec2 UV){
    bool is_star = false;
    float x = UV.x;
    float y = UV.y;
    float r = 0.0, g = 0.0, b = 0.0;
    
    if( sin(600.0 * x + 2.0 * cos(x * 6.0)) *
        (sin(y * 460.0)) > 0.98) {
        if(sin(400.0 * y + cos(x * y * 200.0) + 5.0 * cos(x * 40.0)) > 0.98){
            is_star = true;
        }
    }

    if(is_star){
        r = 1.0 * (1.0 - 0.6 * sin(3.14 * time + sin(100.0 * y)));
        g = 0.6 * (1.0 - 0.3 * sin(3.14 * time));
        b = 1.0 * (1.0 - 0.3 * sin(3.14 * time));
    }

    return vec3(r, g, b);
}

void main(void){
    float x = UV.x;
    float y = UV.y;

    vec4 col = vec4(0.0);
    
    float window = 0.0;

    col.rgb = vec3(0.2, 0.2, 0.2);

    col.r += 0.2 * abs(cos(2.0 * UV.y));
    col.b += 0.3 * abs(cos(2.0 * UV.y));

    // Add sun
    vec2 sun_pos = vec2(0.5, 0.55);

    float sund = distance(sun_pos, UV);

    col.r = 0.4 * (1.0 - sund);
    col.r += 0.1 * pow(1.0 - sund, 3.0);
    col.r += 0.1 * pow(1.0 - sund, 4.0);
    col.r += 0.3 * pow(1.0 - sund, 5.0);
    
    col.rgb += stars(UV);
    
    col.a = 1.0;
    
    gl_FragColor = col;
}
