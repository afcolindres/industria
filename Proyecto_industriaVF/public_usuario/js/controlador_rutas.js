
$(document).ready(function(){
    //alert("hola");
    $("#rutas").html("");
    cargar_rutas();
    mapa_hospital();
});

function obtener_cod_carpeta(id){
    //alert("Obtener codigo carpeta: " + id);
    $.ajax({
        url:`/cookie_carpeta/${id}`,
        method:"GET",
        dataType:"json",
        success:function(res){
            location.href="principal-Sub-carpeta.html"
        },
        error:function(error){
            console.error(error);
        }
    });
}


function cargar_rutas() {
    $.ajax({
		url:"/rutas",
		method:"GET",
		dataType:"json",
		success:function(res){
            for (var i = 0; i < res.length; i++) {
                $("#rutas").append(`
                
                <div class="col-lg-6 text-center mb-4 col-lg-4 col-md-4 col-sm-4">
                    <div class="border rounded" style="box-shadow: 2px 2px 5px #999">
                    <div>
                        <br>
                        <img class="img responsive" src="img/fondo2.png"  width="150" height="150">
                        <h3>${res[i].nombre}</h3>
                        <div class="col-lg-12">
                            <button class="btn btn-dark" type="button" onclick="mostrar_descripcion(${res[i].cod_ruta});"">Descripción</button>
                            <br><br>
                            <button class="btn btn-info" type="button" onclick="ver_mapa(${res[i].cod_ruta});">Mapa</button>
                            <button class="btn btn-success" type="button" onclick="reservar(${res[i].cod_ruta});">Reservar</button>
                        </div>
                    </div><br>
                    <div id="${res[i].cod_ruta}" style="display:none" >
                        <p>${res[i].descripcion} <br>
                        hora de salida: ${res[i].hora_salida}
                        
                        </p>
                    </div>
                    </div>
                </div>`
                );
            }
		},
		error:function(error){
			console.error(error);
		}
	});
}

function mostrar_descripcion(codigo_ruta) {
    parametro=`codigo_ruta=${codigo_ruta}`;
    $.ajax({
		url:"/ruta",
        method:"POST",
        data: parametro,
		dataType:"json",
		success:function(res){
            document.getElementById(`${res[0].cod_ruta}`).style.display="block";
		},
		error:function(error){
			console.error(error);
		}
	});
}

function reservar(codigo_ruta) {
    parametro=`codigo_ruta=${codigo_ruta}`;
    $.ajax({
		url:"/reserva",
        method:"POST",
        data: parametro,
		dataType:"json",
		success:function(res){
            console.log(res);
            if (res[0].mensaje==1) {
                $('#reserva_error').modal('show');
            } 
		},
		error:function(error){
            $('#reserva').modal('show');
		}
	});
}


function ver_mapa(codigo_ruta) {
    parametro=`codigo_ruta=${codigo_ruta}`;
    $.ajax({
		url:"/longitud_latitud",
        method:"POST",
        data: parametro,
		dataType:"json",
		success:function(res){
            mapas (`${res[0].latitud}`,`${res[0].longitud}`);
		},
		error:function(error){
            alert("hay errores garrafales");
		}
	});
}


function mapas (latitud,longitud){
    var container = L.DomUtil.get('map');
    if(container != null){
      container._leaflet_id = null;
    }
    var map = L.map('map').
    setView([14.0886335, -87.1964868], //// centro del mapa hospital
    10);


L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
maxZoom: 20
}).addTo(map)


L.control.scale().addTo(map);
L.marker([latitud, longitud],{draggable: true}).addTo(map);  // datos desde la base de datos
L.marker([14.0886335, -87.1964868],{draggable: true}).addTo(map); /// hospital fijo


L.Routing.control({
 waypoints: [
   L.latLng(latitud, longitud), //datos de la base de datos
   L.latLng(14.0886335, -87.1964868) //// hospital fijo
 ]
}).addTo(map);

}



 function mapa_hospital(){

      var map = L.map('map').
      setView([14.0886335, -87.1964868], //// centro del mapa hospital
      10);


 L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
 attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
 maxZoom: 20
 }).addTo(map)


 L.control.scale().addTo(map);

 L.marker([14.0886335, -87.1964868],{draggable: true}).addTo(map); /// hospital fijo
}