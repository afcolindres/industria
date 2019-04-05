$("#btn-login").click(function(){
    parametros=`correo=${$("#correo").val()}&contrasenia=${$("#contrasenia").val()}`;
    //alert(parametros);
    $.ajax({
        url:"/login",
        method:"POST",
        data:parametros,
        dataType:"json",
        success:function(respuesta){
            //alert("excelente");
             console.log(respuesta.length);
            if(respuesta.length>=1){
                if (respuesta[0].tipo_usuario == 2)
                //alert("estas logiado, solo falta la pagina principal para que te dirrecione ahi");
                window.location.href = "/menu-administrador.html";
                else if (respuesta[0].tipo_usuario == 1)
                window.location.href = "/rutas.html";
            }
            else 
                document.getElementById("usuario-registrado").style.display="block";
        },
        error:function(error){
            console.error(error);
        }
    });
});