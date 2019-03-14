$("#btn-registrar").click(function(){

    ////************************************************************ */
    /////**********************Validacion************************** */
    var name =document.getElementById("nombre").value;
    if( name == "" || name.length == 0 || /^\s+$/.test(name) ) {
        document.getElementById('nombre').style.borderColor = "red";
        return false;
    }
    var apellido =document.getElementById("apellido").value;
    if(apellido == "" || apellido.length == 0 || /^\s+$/.test(apellido) ) {
        document.getElementById('apellido').style.borderColor = "red";
        return false;
    }

    if ($("#email").val()==""){
        document.getElementById("email").style.borderColor='red';
        return false;
    }

    var imail = document.getElementById("email").value;
    if (/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(imail)){
        $("#emailOK").text("correo correcto");
       } else {
        $("#emailOK").text("correo incorrecto");
        return false;
       }

    if ($("#password").val()==""){
        document.getElementById("password").style.borderColor='red';
        return false;
    }

    if ($("#password2").val()==""){
        document.getElementById("password2").style.borderColor='red';
        return false;
    }

    if ($("#password").val()==$("#password2").val() && $("#password").val()!=""){
        document.getElementById("password").style.borderColor='green';
        document.getElementById("password2").style.borderColor='green';
        $("#contra").css("display", "none");
    }else{
        $("#contra").css("display", "block");
        return false;
    }

    var name =document.getElementById("telefono").value;
    if( name == "" || name.length == 0 || /^\s+$/.test(name) ) {
        document.getElementById('telefono').style.borderColor = "red";
        return false;
    }

    var name =document.getElementById("direccion").value;
    if( name == "" || name.length == 0 || /^\s+$/.test(name) ) {
        document.getElementById('direccion').style.borderColor = "red";
        return false;
    }
    
    // var indice = document.getElementById("slg-genero").selectedIndex;
    // if(indice == null  || indice == 0) {
    //     document.getElementById('slg-genero').style.borderColor= "red";
    //     return false;
    // }
 
//***************************************************************************** */
////***********************registro de usuarios******************************* */
    var parametros=`nombre=${$("#nombre").val()}&apellido=${$("#apellido").val()}&email=${$("#email").val()}&password=${$("#password").val()}&tel=${$("#telefono").val()}&dir=${$("#direccion").val()}`;
    var correo= `email=${$("#email").val()}`;
    $.ajax({
         url:"/consultausuario",
         method: "POST",
         data: correo,
         dataType: "json",
         success: function (respuesta) {
             console.log(respuesta.length);
             if(respuesta.length==0){
                $.ajax({
                    url: "/registrarUsuario",
                    method: "POST",
                    data: parametros,
                    dataType: "json",
                    success: function (respuesta2) {
                        //console.log(respuesta);
                        location.href="/login.html";
                    },
                    error: function (error2) {
                        console.error(error2);
                    }
                });
             }
             else{
                $("#usuario-registrado").css("display", "block");
             }
             
         },
         error: function (error) {
             console.error(error);
         }
     });
});
