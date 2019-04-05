var express = require("express");
 var mysql = require("mysql");
var bodyParser = require("body-parser");
// var cookieParser = require("cookie-parser");
var session = require("express-session");
var sha1 = require('sha1');
 var app = express();
 var credenciales = {
     host:"localhost",
     user:"root",
     password:"",
     port:"3306",
     database: "bd_salud"
 };

 //app.use(cookieParser());
app.use(express.static("public"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
// // secret es para generar una cookie en el cliente y esta genera un id e identificar de
// // quien son las variables de session 
app.use(session({secret:"ASDFE$%#%",resave:true, saveUninitialized:true}));

// ///****************Rutas de control************************* */


// //*************** variables de sesion ******************* */
// //Verificar si existe una variable de sesion para poner publica la carpeta public admin
var publicUsuario = express.static("public_usuario");
var publicAdministrador = express.static("public_administrador");
 app.use(
     function(req,res,next){
         if (req.session.correoUsuario){
             //Significa que el usuario si esta logueado
            if (req.session.codigoTipoUsuario == 1)
                 publicUsuario(req,res,next);
            else if (req.session.codigoTipoUsuario == 2)
            publicAdministrador(req,res,next);
         }
         else
             return next();
     }
 ); 
// ///Para agregar seguridad a una ruta especifica:
function verificarAutenticacion(req, res, next){
	if(req.session.correoUsuario)
		return next();
	else
		res.send("ERROR, ACCESO NO AUTORIZADO");
}

// ///******************login*********************** */
app.post("/login",function(req, res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`
                    SELECT ID_persona,correo, contrasenia, tipo_usuario
                    FROM tbl_persona 
                    WHERE correo = ?  and contrasenia = sha1(?)`,
        [req.body.correo, req.body.contrasenia],
        function(error, data, fields){
             if (error){
                 res.send(error);
                 res.end();
             }else{
                 if (data.length==1){
                     req.session.codigoUsuario = data[0].ID_persona;
                     req.session.correoUsuario = data[0].correo;
                     req.session.codigoTipoUsuario = data[0].tipo_usuario;
                 }
                 res.send(data);
                 res.end();
             }
        }
    )
});

// /************   obtener sesion************ */
app.get("/obtener-session",function(req,res){
     res.send("Codigo Usuario: " + req.session.codigoUsuario+
             ", Correo: " + req.session.correoUsuario +
             ", Tipo Usuario: " + req.session.codigoTipoUsuario
     );
     res.end();
});


// /************  cerrar sesion************ */
// app.get("/cerrar-sesion",function(req,res){
//     req.session.destroy();
//     res.redirect('http://localhost:8008');
//     res.end();
// });


// //*********************** verificando si el usuario esta registrado************************** */
app.post("/consultausuario", function(req,res){
    var conexion = mysql.createConnection(credenciales);
     conexion.query(`SELECT ID_persona, correo
                    FROM tbl_persona 
                    WHERE lower(correo)=lower(?)`,
         [req.body.email],
         function(error, data, fields){
             res.send(data);
             res.end();
             conexion.end();
         }
     );
 });

// ///***************************registro de usuarios************************ */
 app.post("/registrarUsuario", function(req,res){
     var conexion = mysql.createConnection(credenciales);
     conexion.query(`INSERT INTO tbl_persona (nombre, apellido, telefono, correo, contrasenia, direccion,tipo_usuario) 
                    VALUES (?,?,?,?,?,?,?)`,
         [req.body.nombre,req.body.apellido,req.body.tel,req.body.email, sha1(req.body.password),req.body.dir,1],
         function(error, data, fields){
             req.session.codigoUsuario = data.insertId;
             req.session.correoUsuario = req.body.email;
             req.session.codigoTipoUsuario = 1;
             res.send(data);
             res.end();
             conexion.end();
         }
     );
 });

 // ///***************************registro de rutas************************ */
 app.post("/registrarRuta", function(req,res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`INSERT INTO tbl_rutas (nombre, descripcion, hora_salida, hora_llegada) 
                    VALUES (?,?,?,?)`,
        [req.body.nombre,req.body.descripcion,req.body.salida,req.body.llegada],
        function(error, data, fields){
            res.send(data);
            res.end();
            conexion.end();
        }
    );
});


 // ///***************************registro de hospital ************************ */
app.post("/registrarHospital", function(req,res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`INSERT INTO tbl_centro_medico (nombre, descripcion, direccion, telefono, pagina_web) 
                    VALUES (?,?,?,?,?)`,
        [req.body.nombre,req.body.descripcion,req.body.direccion,req.body.telefono,req.body.web],
        function(error, data, fields){
            res.send(data);
            res.end();
            conexion.end();
        }
    );
});


app.get("/rutas", function(req,res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`SELECT cod_ruta, nombre, descripcion, hora_salida, hora_llegada
                    FROM tbl_rutas`,
        [],
        function(error, data, fields){
            //console.log(data);
            res.send(data);
            res.end();
            conexion.end();
        }
    );
});


app.post("/reserva", function(req,res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`SELECT cod_ruta, count(*) cantidad
                    FROM tbl_reserva
                    WHERE cod_ruta =?
                    GROUP BY cod_ruta`,
        [req.body.codigo_ruta],
        function(error, data, fields){
            //console.log(data);
            if(data=="" || data[0].cantidad<5  ){
                conexion.query(`INSERT INTO tbl_reserva (cod_usuario, cod_ruta) 
                                VALUES (?,?)`,
                    [req.session.codigoUsuario,req.body.codigo_ruta],
                    function(error, data, fields){
                    }
                );
            }
            else {
                var json=[{mensaje :'1'}];
                console.log(json);
                res.send(json);
            }
            
            res.end();
            conexion.end();
        }
    );
});

app.post("/ruta", function(req,res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`SELECT cod_ruta, nombre, descripcion, hora_salida, hora_llegada
                    FROM tbl_rutas
                    where cod_ruta=?`,
        [req.body.codigo_ruta],
        function(error, data, fields){
            console.log(data);
            res.send(data);
            res.end();
            conexion.end();
        }
    );
});


app.post("/longitud_latitud", function(req,res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query(`SELECT cod_ruta,  latitud, longitud
                    FROM tbl_rutas
                    WHERE cod_ruta=?`,
        [req.body.codigo_ruta],
        function(error, data, fields){
            console.log(data);
            res.send(data);
            res.end();
            conexion.end();
        }
    );
});

app.listen(8015, function(){ 
    console.log("Servidor iniciado en el puerto 8015");
});