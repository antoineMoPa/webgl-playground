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

vec4 road(float x, float y){
    vec4 col = vec4(0.0);;

    // Double yellow at middle
    if(x > 0.48 && x < 0.49 || x > 0.51 && x < 0.52){
        col = vec4(0.6, 0.5, 0.0, 1.0);
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
        float fac_x = pow(cos(x * PI),3.0);
        float fac_y = pow(cos(y * PI),3.0);
        vec2 rg = vec2(0.3, 0.2) * abs(fac_x) * abs(fac_y);

        // Only take 1/2 occurences
        if(x_road && fac_y > 0.0){
            col.rg += rg;
        } else if(y_road && fac_x > 0.0){
            col.rg += rg;
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
        col = roof(x, y);
    }
    
    col.a = 1.0;
    
    gl_FragColor = col;
}
