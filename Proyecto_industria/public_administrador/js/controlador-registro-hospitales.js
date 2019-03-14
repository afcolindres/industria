$("#btn-hospital").click(function(){

//***************************************************************************** */
////***********************registro de rutas******************************* */
    var parametros=`nombre=${$("#txt_nombre").val()}&descripcion=${$("#txt_descripcion").val()}&direccion=${$("#txt_direccion").val()}&telefono=${$("#txt_telefono").val()}&web=${$("#txt_web").val()}`;
    alert(parametros);
    $.ajax({
        url: "/registrarHospital",
        method: "POST",
        data: parametros,
        dataType: "json",
        success: function (respuesta2) {
            //console.log(respuesta);
            document.getElementById("hospital-registrada").style.display="block";
        },
        error: function (error2) {
            console.error(error2);
        }
    });
});
