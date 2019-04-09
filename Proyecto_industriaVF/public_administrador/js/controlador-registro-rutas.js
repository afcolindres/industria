$("#btn-ruta").click(function(){

//***************************************************************************** */
////***********************registro de rutas******************************* */
    var parametros=`nombre=${$("#text_nombre").val()}&descripcion=${$("#text_descripcion").val()}&salida=${$("#text_salida").val()}&llegada=${$("#text_llegada").val()}&longitud=${$("#text_longitud").val()}`;
    //alert(parametros);
    $.ajax({
        url: "/registrarRuta",
        method: "POST",
        data: parametros,
        dataType: "json",
        success: function (respuesta2) {
            //console.log(respuesta);
            document.getElementById("ruta-registrada").style.display="block";
        },
        error: function (error2) {
            console.error(error2);
        }
    });
});
