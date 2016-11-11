
function three_canvas(params) {
    var camera, renderer;
    
    var canvas = params.canvas;
    
    var scene = new THREE.Scene();

    var uniforms = {
        time: {value: 1.0},
    };
    
    camera = new THREE.PerspectiveCamera(
        75,
        canvas.width / canvas.height,
        1, 10000
    );

    camera.position.y = 40;
    camera.position.x = -400;
    camera.rotation.y = -2;
    
    // World sphere
    var sgeometry = new THREE.SphereGeometry(1000, 32, 32);
    var smaterial = new THREE.ShaderMaterial({
        vertexShader: params.shaders["sky"].vertex,
        fragmentShader: params.shaders["sky"].fragment,
        side: THREE.BackSide
    });

    // Ground
    var gmaterial = new THREE.ShaderMaterial({
        vertexShader: params.shaders["road_grid"].vertex,
        fragmentShader: params.shaders["road_grid"].fragment,
        side: THREE.BackSide
    });

    var ggeometry = new THREE.BoxGeometry( 10000, 0.3, 10000 );
    var gcube = new THREE.Mesh(ggeometry, gmaterial);
    scene.add(gcube);
    
    var sphere = new THREE.Mesh(sgeometry, smaterial);
    sphere.position.x = 0.0;
    sphere.position.y = 0.0;
    sphere.position.z = 0.0;
    
    scene.add(sphere);

    // Buildings
    var block_w = 10000 / 2000;
    var material = new THREE.ShaderMaterial({
        uniforms: uniforms,
        vertexShader: params.shaders["buildings"].vertex,
        fragmentShader: params.shaders["buildings"].fragment,
        side: THREE.DoubleSide
    });
    
    var city_r = 55; // diameter in terms of buildings number
    
    for(var i = 0; i < 2 * city_r; i++){
        for(var j = 0; j < 2 * city_r; j++){
            var radius = Math.sqrt( Math.pow(i - city_r, 2) +
                               Math.pow(j - city_r, 2) );

            // radius ratio
            var r = radius/city_r;
            
            // Only add in radius
            if(radius > city_r){
                continue;
            }

            // Do not always add building
            // (outside downtown)
            if(r > 0.1 && Math.random() < r){
                continue;
            }

            
            // Randomness
            var height = Math.random() * 20 + 10;

            // City center
            height += 100 * Math.pow(1.0 - radius/city_r, 10) * Math.random();
            
            //height += 40 * Math.cos(i/20 + 1);
            //height += 40 * Math.cos(j/20 + 1);
            
            geometry = new THREE.BoxGeometry(block_w, height, block_w);
            mesh = new THREE.Mesh(geometry, material);
            mesh.position.x = i * (block_w * 2) - 10 * city_r - 2.5;
            mesh.position.y = 0.0;
            mesh.position.z = j * (block_w * 2) - 10 * city_r - 2.5;
            scene.add(mesh);
        }
    }
    
    renderer = new THREE.WebGLRenderer({
        canvas: canvas
    });

    var exports = {};

    var playing = true;
    
    var clock = new THREE.Clock();
    
    function update(time){
        var delta = clock.getDelta();
        time = time % 10;
        uniforms.time.value = time;
        // Some camera move
        camera.position.x += 0.3 * Math.cos(0.4 * time);
        camera.position.y += 0.2 * Math.cos(0.4 * time);
        camera.position.z += 0.2 * Math.cos(0.4 * time);
    }

    animate();
    
    function animate() {
        requestAnimationFrame(animate);

        var time = new Date().getTime()/1000;
        update(time);
        
        if(playing){
            uniforms.time.value += 0.05;
            renderer.render(scene, camera);
        }
    }

    exports.start = function(){
        playing = true;
    };

    exports.stop = function(){
        playing = false;
    };
    
    exports.canvas = canvas;
    
    exports.render = function(time){
        update(time);
        
        renderer.render(scene, camera);
    };
    
    return exports;
}
