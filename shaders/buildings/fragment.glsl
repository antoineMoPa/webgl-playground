varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;

#define PI 3.1416

uniform float time;

vec4 roof(float x, float y){
    vec4 col;
    float x_m = mod(x, 1.0);
    float y_m = mod(y, 1.0);

    if( x_m < 0.1 || x_m > 0.9 ||
        y_m < 0.1 || y_m > 0.9 ){
        col.rgb = 0.8 * vec3(0.1, 0.2, 0.2);
    } else {
        col.rgb = vec3(0.1, 0.2, 0.2);
        col.r += 0.02 + 0.03 * sin(0.001 * x * y);
        col.g += 0.02 + 0.03 * sin(0.0015 * x * y);
        col.b += 0.02 + 0.03 * sin(0.0013 * x * y);
                
        float fac = 1.0 - cos(2.0 * x_m * PI);
        
        fac *= 1.0 - cos(2.0 * y_m * PI);
        
        col *= 0.1 * fac + 0.9;
    }

    col.a = 1.0;
            
    return col;
}

void main(void){
    float x = UV.x;
    float y = vpos.y;

    vec4 col = vec4(0.0);
    
    float window = 0.0;
    
    col.rgb = vec3(0.1, 0.2, 0.2);
    
    if(abs(nor.y) < 0.2){
        // Not roof or floor
        if(sin(20.0 * x) > 0.0){
            if(sin(4.0 * y) > 0.5){
                window = 1.0;
            }
        }

        col.r += 0.5 * window;
        col.g += 0.3 * window;

        if(window > 0.5){
            // Some jitter
            col.r *= 1.0 + 0.2 * sin(0.1 * vpos.x * vpos.z);
            col.g *= 1.0 + 0.3 * sin(0.2 * vpos.x * vpos.y);
            col.b *= 1.0 + 0.3 * sin(0.004 * vpos.x * vpos.z);
        } else {
            // Some jitter
            col.r *= 1.0 + 0.2 * sin(0.01 * vpos.x * vpos.z);
            col.g *= 1.0 + 0.3 * sin(0.02 * vpos.x * vpos.y);
            col.b *= 1.0 + 0.3 * sin(0.04 * vpos.x * vpos.z);
        }
        
    } else {
        // Either roof or floor
        col = roof(UV.x, UV.y);
    }
    
    col.a = 1.0;
    
    gl_FragColor = col;
}
