
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

    camera.position.y = 4;
    camera.position.x = 0;
    camera.rotation.y = 3;
    
    // World sphere
    var sgeometry = new THREE.SphereGeometry(1000, 32, 32);
    var smaterial = new THREE.ShaderMaterial({
        vertexShader: params.shaders["sky"].vertex,
        fragmentShader: params.shaders["sky"].fragment,
        side: THREE.BackSide
    });

    // Ground
    var gmaterial = new THREE.ShaderMaterial({
        vertexShader: params.shaders["mountains"].vertex,
        fragmentShader: params.shaders["mountains"].fragment,
        side: THREE.DoubleSide
    });

    var ggeometry = new THREE.PlaneGeometry( 200, 200, 100, 100 );
    var ground = new THREE.Mesh(ggeometry, gmaterial);

    ground.rotation.x = Math.PI/2.0;
    
    scene.add(ground);
    
    var sphere = new THREE.Mesh(sgeometry, smaterial);
    sphere.position.x = 0.0;
    sphere.position.y = 0.0;
    sphere.position.z = 0.0;
    
    scene.add(sphere);

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
