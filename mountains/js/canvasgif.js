
var frame = 0;
var mouse = [0.0, 0.0];
var smooth_mouse = [0.0, 0.0];

// The main canvas
var canvas = qsa(".result-canvas")[0];
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

var ratio = canvas.width / window.height;

enable_mouse(canvas);

function enable_mouse(can){
    can.hover = false;
    
    mouse = [can.width / 2.0, can.height / 2.0];
    smooth_mouse = [0.5, 0.5];

    can.addEventListener("mouseenter", function(e){
        can.hover = true;
        mouse = [can.width / 2.0, can.height / 2.0];
    });
    
    can.addEventListener("mousemove", setMouse);
    
    function setMouse(e){
        var x, y;
        
        x = e.clientX
            - can.offsetLeft
            - can.offsetParent.offsetLeft
            + window.scrollX;
        y = e.clientY
            - can.offsetTop
            - can.offsetParent.offsetTop
            + window.scrollY;
        
        mouse = [x, y];
    }
    
    can.addEventListener("mouseleave", function(){
        can.hover = false;
        mouse = [can.width / 2.0, can.height / 2.0];
    });
}

function get_file(file, callback){
    try{
        var xhr = new XMLHttpRequest;
        xhr.open('GET', "./" + file, true);
        xhr.onreadystatechange = function(){
            if (4 == xhr.readyState) {
                var val = xhr.responseText;
                callback(val);
            }
        };
        xhr.send();
    } catch (e){
        // Do nothing
        // Errors will be logged anyway
    }
}

var shaders = {};
var shader_count = 0;
var total_shaders = 0;

shaders.sky = {};

function on_shader_loaded(){
    shader_count++;

    if(shader_count == total_shaders){
        can = three_canvas({
            canvas: canvas,
            shaders: shaders
        });
    }
}

var can, gif_can;

load_shader("mountains");
load_shader("sky");

/* load a vertex + fragment shader set */
function load_shader(name){
    total_shaders += 2;
    shaders[name] = {};
    get_file("./shaders/" + name + "/fragment.glsl", function(value){
        shaders[name].fragment = value;
        on_shader_loaded();
    });
    
    get_file("./shaders/" + name + "/vertex.glsl", function(value){
        shaders[name].vertex = value;
        on_shader_loaded();
    });
}
