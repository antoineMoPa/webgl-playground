varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;
varying vec3 wpos;

#define PI 3.1416

uniform float time;

vec4 road(float x, float y){
    vec4 col = vec4(0.0);;

    // Double yellow at middle
    if(x > 0.48 && x < 0.49 || x > 0.51 && x < 0.52){
        col = vec4(0.0, 0.3, 0.8, 1.0);
    }

    // White at quarter
    if(x > 0.245 && x < 0.255 || x > 0.745 && x < 0.755){
        if(mod(4.0 * y, 2.0) < 1.0){
            col = vec4(0.6, 0.6, 0.6, 1.0);
        }
    }
    
    return col;
}

void main(void){
    float x = UV.x * 2000.0;
    float y = UV.y * 2000.0;

    vec4 col = vec4(0.0);
    
    bool x_road = false;
    bool y_road = false;
    
    if(mod(float(x), 4.0) < 1.0){
        x_road = true;
    }

    if(mod(float(y), 2.0) < 1.0){
        y_road = true;
    }

    col.rgb = vec3(0.1);
    
    if(x_road && y_road){
        // Corner
    }

    if(x_road || y_road){
        float fac_x = pow(cos(x * PI),4.0);
        float fac_y = pow(cos(y * PI),4.0);
        float light = 0.3 *  abs(fac_x) * abs(fac_y);

        // Only take 1/2 occurences
        if(x_road && fac_y > 0.0){
            col.b += light;
        } else if(y_road && fac_x > 0.0){
            col.b+= light;
        }
    }

    // Road markings (x)
    if(x_road && !y_road){
        float x_road = mod(x, 4.0);
        
        col += road(x_road, y);
    }
    // (y)
    if(y_road && !x_road){
        float y_road = mod(y, 2.0);
        
        col += road(y_road, x);
    }

    if(!x_road && !y_road){
        col = vec4(0.0);
    }

    col *= 1.0 - wpos.z / 800.0;
    
    col.a = 1.0;
    
    gl_FragColor = col;
}
