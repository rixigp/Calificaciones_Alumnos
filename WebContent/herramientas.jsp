<!--#
# Copyright (C) 2014 Carlos III University of Madrid


# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor
# Boston, MA 02110-1301, USA.
#
# author: Ricardo García-Prieto (100073317@alumnos.uc3m.es)
# tutor: Pablo Basanta (pbasanta@it.uc3m.es)
#
-->
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import = 'bbdd.GestorBBDD'  %>
<% 
HttpSession sesion = request.getSession(true);

String ultimaSesion = (String) sesion.getAttribute("ultimaSesion"); 
if(ultimaSesion==null) response.sendRedirect("index.jsp");

if(ultimaSesion!=null){
if(ultimaSesion.equals("")) ultimaSesion = "Nunca";

//para redigirir al usuario correctamente
String tipoUsuario = (String) sesion.getAttribute("tipoUsuario"); 
if (tipoUsuario == null) tipoUsuario="0";//Si no hay usuario le llevamos a index

if(tipoUsuario.equals("admin")){
	String nombre = (String) sesion.getAttribute("nombre");
	String email = (String) sesion.getAttribute("email");
%>
<!doctype html>
<html lang="es">
<head>
	<!-- Define Charset -->
	<meta charset="UTF-8">
	
	<!-- Page Title -->
	<title>Calificaciones Alumnos - Alumno</title>
    
	<!--Modernizr-->
    <script src="js/modernizr.js" type="text/javascript"></script>

	<!-- Responsive Metatag --> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<!-- Favicon -->
    <link rel="shortcut icon" href="favicon.html">
	
	<!-- Stylesheet
	===================================================================================================  -->
	<link rel="stylesheet" href="styles/font/fontello.css">
	<link rel="stylesheet" href="styles/css/bootstrap.min.css">
	<link rel="stylesheet" href="styles/css/style.css">
	<link rel="stylesheet" href="styles/css/media-queries.css">
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
    <![endif]-->
        
</head>
	
<body>
	<!-- Header -->
	<header>
	    <div class="navbar navbar-default" role="navigation">
	      <div class="container">
	        <div class="navbar-header">
	          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	          </button>
	          <a class="navbar-brand" href="#"><img src="img/logo.png" alt="logo brand"></a>
	        </div>
	        <div class="navbar-collapse collapse">
	          <ul class="menu navbar-nav navbar-right" style="list-style:none; margin-top: 15px; display: block;">
	            <li><a href="index.jsp">Home</a></li>
	          
	             <li  class="active"><a href="herramientas.jsp">Herramientas</a></li>
	              <li><a href="perfil.jsp">Perfil usuario</a></li>
	           	 <li><a href="CerrarSesion">Cerrar sesión</a></li>	
	           
	            
                <li  class="tooltip_hover" title="Twitter" data-placement="bottom"  style="font-size:25px; margin-top:-5px;"  data-toggle="tooltip"><a class="icon-twitter-circled1 effect_icon" href="https://twitter.com/uc3m"><i class="icon-twitter-circled"></i></a></li>
                <li class="tooltip_hover" title="Facebook" data-placement="bottom"  style="font-size:25px; margin-top:-5px;"  data-toggle="tooltip"><a class="icon-facebook-circled1 effect_icon"  href="https://www.facebook.com/uc3m" ><i class="icon-facebook-circled"></i></a></li>				
               
	          </ul>
	           
	        </div><!--/.nav-collapse -->
	      </div>
	      
	    </div>
	</header>
	<!-- end Header -->

	<!-- Slider and Form -->
	<section id="menu-slider" class="slider">
        <div class="container">
            <div style="float:left; width: 97%;">
                

            <!-- form -->
         
            <div style="float:left; padding-left: 20px;">
	            <h2 class="title">
	                        Bienvenido
	            </h2>
	       </div>
	             <div style="padding-left: 20px; padding-top: 40px; float:left; color:#fff" class="form-group input-group-lg">
	                   <%=nombre %>
	             </div>
            
            <div style="float:right; padding-top: 40px; ">
            
            	<p>Ultima sesión: <%=ultimaSesion%> </p>
            
            	
            </div>
            </div>
            <!-- /form -->
            
            
        </div>
	</section>
	<!-- end Slider and Form -->

<section id="options" class="clearfix navbar navbar-default col-lg-6 col-lg-offset-3">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul id="filters" class="option-set clearfix nav navbar-nav" data-option-key="filter">
                            <% 
        GestorBBDD gestor = new GestorBBDD();
        String [] datosLDAP = gestor.datosLDAP();
        String login = (String) sesion.getAttribute("login"); 
        
        String [] asignaturas = gestor.listarAsignaturas(); 
        String [] profesores = gestor.listarProfesores();
        String [] profesorActivo = gestor.profesorActivo();
        String [] alumnos = gestor.listarAlumnos();
        
        String [] usuarios = gestor.listarUsuarios();
        
        int i,j,usu,prof,prof2,asig;
        %>
       
        <li style="padding: 10px 15px;"><a href="#CrearUsuario">Crear usuario</a></li>
  		<li style="padding: 10px 15px;"><a href="#CrearAsignatura">Crear asignatura</a></li>
  		<li style="padding: 10px 15px;"><a href="#AsignarProfesores">Asignar profesores</a></li>
        <li style="padding: 10px 15px;"><a href="#AsignarAlumnos">Asignar alumnos</a></li>
        <li style="padding: 10px 15px;"><a href="#ModificarLDAP">Modificar LDAP</a></li>
        <li style="padding: 10px 15px;"><a href="#ResetearContrasena">Resetear Contraseña</a></li>
                                    </ul>
        
                        </div>
                    </section>
                    
 <script type="text/javascript">
function activar1() {
  frm = document.forms[0];
  for(i=0; ele = frm.elements[i]; i++){
    ele.disabled = !ele.disabled;
    if (i==4) break;
  }
}
</script>                   
             
                    <!-- crearUsuario -->
	<section id="CrearUsuario" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
         
                    
              <div class="col-xs-12 col-lg-10 col-lg-offset-1">
              <h2 class="title"> Crear usuario local </h2>
                      <form role="form" action="CrearUsuario" method="post">
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="login" class="label">Login</label>
                                <input id="login" type="text" name="login" value="" placeholder="Login" class="form-control input-lg"  required disabled />
                            </div>
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="nombreUsuario" class="label">Nombre de Usuario</label>
                                <input id="nombreUsuario" type="text" name="nombreUsuario" value="" placeholder="Nombre usuario"  class="form-control input-lg" required  disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6">
                                <label for="email" class="label">E-mail</label>
                                <input type="email" name="email" value="" placeholder="alumno@dominio.com" class="form-control input-lg" required disabled/>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label for="tipo" class="label">Tipo de usuario</label>
                                <select class="form-control input-lg" name="tipo" disabled>
						           <option name="" value="alumno" >Alumno</option>
								   <option name="" value="profesor" >Profesor</option>
								   <option name="" value="admin" >Administrador</option>
								
								</select> </div>
                        </div>
                      
                        <div class="content_button">
                       <span style="width:210px; margin-right:15px; height:51px" class="btn-default btn-lg button_generic" onclick="activar1()" >
                               
                                Desbloquear
                          </span>
                            <button class="btn-default btn-lg button_generic" type="submit"  disabled>
                                <i class="icon-paper-plane"></i>
                                Crear usuario
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end crearUsuario -->
                   
  <script type="text/javascript">
function activar2() {
  frm = document.forms[1];
  for(i=0; ele = frm.elements[i]; i++){
    ele.disabled = !ele.disabled;
    if (i==2) break;
  }
}
</script>              
    <!-- CrearAsignatura -->
	<section id="CrearAsignatura" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
        
              <div class="col-xs-12 col-lg-10 col-lg-offset-1">
               <h2 class="title"> Crear asignatura </h2>
                      <form role="form" action="CrearAsignatura" method="post">
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="asignatura" class="label">Login</label>
                                <input id="asignatura" type="text" name="asignatura" value="" placeholder="Asignatura" class="form-control input-lg"  required disabled />
                            </div>
                            
						
                            <div class="col-xs-12 col-md-6 col-lg-6">
                              <label for="login" class="label">Profesor</label>
						        <select class="form-control input-lg" name="profesor" disabled >
						         <%   for( prof = 0; prof<profesores.length; prof++){   %>
									  <option name="" value="<%=profesores[prof]%>"><%=profesores[prof]%></option>
								<%} %>
								</select>
                            </div>
                          
                        </div>
                       
                     
                      
                        <div class="content_button">
                        <span style="width:210px; margin-right:15px; height:51px" class="btn-default btn-lg button_generic" onclick="activar2()" >
                               
                                Desbloquear
                          </span>
                            <button class="btn-default btn-lg button_generic" type="submit" disabled>
                                <i class="icon-paper-plane"></i>
                                Crear asignatura
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end CrearAsignatura --> 
 
 
   <script type="text/javascript">
function activar3() {
  frm = document.forms[2];
  for(i=0; ele = frm.elements[i]; i++){
    ele.disabled = !ele.disabled;
   
  }
}
</script>                     
             <!-- AsignarProfesores -->
	<section id="AsignarProfesores" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
        
              <div class="col-xs-12 col-lg-10 col-lg-offset-1">
               <h2 class="title"> Asignar profesores a asignaturas </h2>
                      <form role="form" action="AsignarProfesores" method="post">
                        <div class="form-group">
                         <%   for( asig = 0; asig<asignaturas.length; asig++){  
                        	 
                         %>
						
                            <div class="col-xs-12 col-md-6 col-lg-6">
                              <label for="login" class="label"><%=asignaturas[asig] %></label>
						        <select class="form-control input-lg" name="<%=asignaturas[asig] %>" disabled >
						         <%   for( prof2 = 0; prof2<profesores.length; prof2++){   %>
									  <option name="" <%if(profesorActivo[asig].equals(profesores[prof2])){ %> selected="selected" <%}%> value="<%=profesores[prof2]%>"><%=profesores[prof2]%></option>
								<%} %>
								</select>
                            </div>
                           <%} %>
                           
                        </div>
                        
                        <div class="content_button">
                       <span style="width:210px; margin-right:15px; height:51px" class="btn-default btn-lg button_generic" onclick="activar3()" >
                               
                                Desbloquear
                          </span>
                            <button class="btn-default btn-lg button_generic" type="submit" disabled >
                                <i class="icon-paper-plane"></i>
                                Asignar profesores
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end AsignarProfesores -->             
                    
  
   <script type="text/javascript">
function activar4() {
  frm = document.forms[3];
  for(i=0; ele = frm.elements[i]; i++){
    ele.disabled = !ele.disabled;
    
  }
}
</script>                     
             <!-- AsignarAlumnos -->
	<section id="AsignarAlumnos" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
        
              <div class="col-xs-12 col-lg-10 col-lg-offset-1">
               <h2 class="title"> Asignar alumnos a asignaturas </h2>
                      <form role="form" action="AsignarAlumnos" method="post">
                        <div class="form-group">
                        
                        
                         <%   for( i = 0; i<asignaturas.length; i++){ 
                        	
                        	 String [] alumnosActivos = gestor.alumnosActivos(asignaturas[i]);
                        	 int longitudAlumnosActivos = alumnosActivos.length;
                        	
                        	 int p = 0;
                        	 %>
							 <div class="col-xs-12 col-md-6 col-lg-6">
                              <label class="label"><%=asignaturas[i] %></label>
						        <select  name="<%=asignaturas[i] %>" disabled multiple="multiple">
						    
						         <%   for( j = 0; j<alumnos.length; j++){  %> 
						         		
									  <option name="" <%for(int k = 0; k<alumnosActivos.length; k++){
									
										  if(alumnosActivos[k].equals(alumnos[j]))  { %> 
										  selected="selected" <%}}%>   value="<%=alumnos[j] %>"><%=alumnos[j]%></option>
								<%} %>
							
							</select>
                            </div>
                           <%} %>
                           
                        </div>
                        
                        <div class="content_button">
                       <span style="width:210px; margin-right:15px; height:51px" class="btn-default btn-lg button_generic" onclick="activar4()" >
                               
                                Desbloquear
                          </span>
                            <button class="btn-default btn-lg button_generic" type="submit" disabled >
                                <i class="icon-paper-plane"></i>
                                Asignar alumnos
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end AsignarProfesores -->             
                                       
	
<script type="text/javascript">
function activar5() {
  frm = document.forms[4];
  for(i=0; ele = frm.elements[i]; i++){
    ele.disabled = !ele.disabled;
    if (i==4) break;
  }
}
</script>

	<!-- modificarLDAP -->
	<section id="ModificarLDAP" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
        
              <div class="col-xs-12 col-lg-10 col-lg-offset-1">
               <h2 class="title"> Modificar datos LDAP </h2>
                      <form role="form" action="ModificarLDAP" method="post">
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="provider_url" class="label">Provider url</label>
                                <input  id="provider_url" type="text" name="provider_url" value="<%=datosLDAP[0] %>" class="form-control input-lg"  disabled />
                            </div>
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="basedn" class="label">Basedn</label>
                                <input id="basedn" type="text" name="basedn" value="<%=datosLDAP[1] %>" class="form-control input-lg"   disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6">
                                <label for="version" class="label">Version</label>
                                <input type="text" name="version" value="<%=datosLDAP[2] %>" class="form-control input-lg" disabled />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label for="securityProtocol" class="label">Security Protocol</label>
                                <input type="text" name="securityProtocol" value="<%=datosLDAP[3] %>" class="form-control input-lg" disabled />
                            </div>
                        </div>
                      
                        <div class="content_button">
                         <span style="width:210px; margin-right:15px; height:51px" class="btn-default btn-lg button_generic" onclick="activar5()" >
                               
                                Desbloquear
                          </span>
                            <button class="btn-default btn-lg button_generic" type="submit" disabled>
                                <i class="icon-paper-plane"></i>
                                Modificar LDAP
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end modificarLDAP -->
	
	 <script type="text/javascript">
function activar6() {
  frm = document.forms[5];
  for(i=0; ele = frm.elements[i]; i++){
    ele.disabled = !ele.disabled;
    if (i==1) break;
  }
}
</script>              
    <!-- ResetearContrasenas -->
	<section id="ResetearContrasena" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
        
              <div class="col-xs-12 col-lg-10 col-lg-offset-1">
               <h2 class="title"> Resetear contraseñas </h2>
                      <form role="form" action="ResetearContrasena" method="post">
                        <div class="form-group">
                           
						
                            <div class="col-xs-12 col-md-6 col-lg-6">
                              <label for="login" class="label">Usuario</label>
						        <select class="form-control input-lg" name="usuario" disabled >
						         <%   for( usu = 0; usu<usuarios.length; usu++){   %>
									  <option name="" value="<%=usuarios[usu]%>"><%=usuarios[usu]%></option>
								<%} %>
								</select>
                            </div>
                          
                        </div>
                       
                     
                      
                        <div class="content_button">
                        <span style="width:210px; margin-right:15px; height:51px" class="btn-default btn-lg button_generic" onclick="activar6()" >
                               
                                Desbloquear
                          </span>
                            <button class="btn-default btn-lg button_generic" type="submit" disabled>
                                <i class="icon-paper-plane"></i>
                                Resetear contraseña
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end CrearAsignatura --> 

	
<%
String modificarLDAP = (String)sesion.getAttribute("modificarLDAP");

if(modificarLDAP!=null){
	if(modificarLDAP.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Datos LDAP cambiados correctamente!");
	</script>
	<%
}else{%>
	<script type="text/javascript">
	  alert("Fallo al modificar los datos LDAP!");
	</script>
	<%
}sesion.setAttribute("modificarLDAP", null);}
%>


<%
String crearUsuario = (String)sesion.getAttribute("crearUsuario");

if(crearUsuario!=null){
	if(crearUsuario.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Usuario creado correctamente!");
	</script>
	<%
	}else if(crearUsuario.equals("2")){ 
		sesion.setAttribute("crearUsuario", null); %>
		<script type="text/javascript">
	  alert("Usuario ya existente!");
	</script>
<%}else{%>
	<script type="text/javascript">
	  alert("Fallo al crear el usuario!");
	</script>
	<%
}sesion.setAttribute("crearUsuario", null);}
%>

<%
String crearAsignatura = (String)sesion.getAttribute("crearAsignatura");

if(crearAsignatura!=null){
	if(crearAsignatura.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Asignatura creada correctamente!");
	</script>
	<%
}else{%>
	<script type="text/javascript">
	  alert("Fallo al crear la asignatura!");
	</script>
	<%
}sesion.setAttribute("crearAsignatura", null);}
%>
<%
String asignarProfesores = (String)sesion.getAttribute("asignarProfesores");

if(asignarProfesores!=null){
	if(asignarProfesores.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Profesores asignados correctamente!");
	</script>
	<%
}else{%>
	<script type="text/javascript">
	  alert("Fallo al asignar profesores!");
	</script>
	<%
}sesion.setAttribute("asignarProfesores", null);}
%>
<%
String asignarAlumnos = (String)sesion.getAttribute("asignarAlumnos");

if(asignarAlumnos!=null){
	if(asignarAlumnos.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Alumnos asignados correctamente!");
	</script>
	<%
}else{%>
	<script type="text/javascript">
	  alert("Fallo al asignar alumnos!");
	</script>
	<%
}sesion.setAttribute("asignarAlumnos", null);}
%>

<%
String resetearContrasena = (String)sesion.getAttribute("resetearContrasena");

if(resetearContrasena!=null){
	if(resetearContrasena.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Contraseña reseteada correctamente!");
	</script>
	<%
}else{%>
	<script type="text/javascript">
	  alert("Fallo al resetear contraseña!");
	</script>
	<%
}sesion.setAttribute("resetearContrasena", null);}
%>

    <!-- Go to top arrow -->
    <section class="arrow">
        <div class="container">    
            <div class="row">
                <div class="col-sm-12">
                     <a href="#" id="scroll_up"><i class="icon-up-open"></i></a>
                </div>
            </div>
        </div>
    </section>
    <!-- end Go to top arrow -->


	<!-- Footer -->
	<footer>
        


        <div class="menu_footer text-center container">
            <div class="row">
                <div class="col-sm-12">
                    <ul class="list-unstyled">
                        <li>
                            <a href="#">© 2014 Copyright - Notas Alumnos - UC3M.</a>
                        </li>
                        <li>
                            <a href="#">Terms & Conditions</a>
                        </li>
                        <li>
                            <a href="#">Privacy Policy</a>
                        </li>
                        <li>
                            <a href="#">API License Agreement</a>
                        </li>
                        <li class="last">
                            <a href="#">Created by Ricardo García-Prieto</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
	</footer>
	<!-- end Footer -->



    
    <!-- ======================= JQuery libs =========================== -->

        <!-- jQuery -->
        <script src="js/jquery-1.9.1.min.js"></script>

        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js"></script>

        <!--[if lte IE 8]>
            <script src="js/respond.min.js"></script>
        <![endif]-->

        <!--Scroll To-->         
        <script src="js/nav/jquery.scrollTo.js"></script> 
        <script src="js/nav/jquery.nav.js"></script>

        <!-- Video Responsive-->
        <script src="js/fitvids/jquery.fitvids.js"></script>

        <!--filter portfolio-->
        <script src="js/isotope/jquery.isotope.js" type="text/javascript"></script>

    	<!-- Fixed menu -->
        <script src="js/jquery-scrolltofixed.js"></script> 

        <!-- clock -->
        <script src="js/clock/jquery.js"></script>
        <script src="js/clock/modernizr-2.js"></script>
        <script src="js/clock/main.js"></script>

    	<!-- Custom -->
        <script src="js/script.js"></script>

  <!-- ======================= End JQuery libs ======================= -->
</body>
</html>
<%}else if (tipoUsuario.equals("0")) {%>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=index.jsp">

<%}else if (tipoUsuario.equals("profesor")){%>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=profesor.jsp">
<%}else if (tipoUsuario.equals("alumno")){%>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=alumno.jsp">
<%} 
}%>