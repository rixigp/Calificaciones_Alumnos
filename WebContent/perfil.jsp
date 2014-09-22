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
<% 
HttpSession sesion = request.getSession(true);

String ultimaSesion = (String) sesion.getAttribute("ultimaSesion"); 
String tipoConexion = (String) sesion.getAttribute("tipoConexion"); 
if(ultimaSesion==null) response.sendRedirect("index.jsp");

if(ultimaSesion!=null){
if(ultimaSesion.equals("")) ultimaSesion = "Nunca";



//para redigirir al usuario correctamente
String tipoUsuario = (String) sesion.getAttribute("tipoUsuario"); 


if(tipoUsuario != null){
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
	            <% if( tipoUsuario.equals("alumno") || tipoUsuario.equals("profesor") ) {%>
	             <li><a href=<%=tipoUsuario %>.jsp>Asignaturas</a></li>
	           <%} %>
	           <%if(tipoUsuario.equals("admin")){%>
	             <li><a href=herramientas.jsp>Herramientas</a></li>
	           <%} %>
	           	<li  class="active"><a href="perfil.jsp">Perfil usuario</a></li>
	         
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
        

    

      
	<!-- cambiarContrasena -->
     <section  id="perfil"  class="price generic">
        <div class="container text-center">
	
            <div class="row">
                <article class="item col-xs-12 ">
                    <div class="pricely-chart pricely-professional" style="margin-left: 0%">
                    <table>
                    <tr>
                   <td align="left" width="130px;">Nombre</td><td align="left"> <%=nombre %></td>
                   </tr>
                   <tr>
                   <td align="left">Email</td> <td align="left"><%=email %></td>
                    </tr>
                    <tr>
                   <td align="left">Tipo Usuario</td> <td align="left"><%=tipoUsuario %></td>
                    </tr>
                    <tr>
                   <td align="left">Ultima sesión</td> <td align="left"><%=ultimaSesion %></td>
                    </tr>
                    </table>
                   
                   <h3 style="text-align:left">Cambiar contraseña</h3>
                   <div style="width: 320px;">
                       <% 
       
      					  if(tipoConexion.equals("local")){
       
       					 %>
       					 <script type="text/javascript">
							function activar1() {
							  frm = document.forms[0];
							  for( i=0; ele = frm.elements[i]; i++){
							    ele.disabled = !ele.disabled;
							   
							  }
							}
							
							function comprobarClave(){ 
								frm = document.forms[0];
								actualPass = frm.actualPass.value;
								nuevaPass = frm.nuevaPass.value;
							   	nuevaPass2 = frm.nuevaPass2.value;
							
							   	if (nuevaPass == nuevaPass2){ 
							   		if(actualPass!="")
							   			frm.submit();	
							   		else
							   			alert("La contraseña actual esta vacia \nIntroduce algún valor");
							   	}	else 
							   		alert("Las dos claves son distintas\nVuelva a introducirlas correctamente");
							} 
							
							</script>   
                   <form role="form" name="formCambiarContrasena" action="CambiarContrasena" method="post">
                      
                            <div style="float:left; width: 320px;">
                                <label for="login" class="label">Antigua contraseña</label>
                                <input type="password" name="actualPass" value="" placeholder="Contraseña actual" class="form-control input-lg"  required disabled />
                            </div>
                         
                            <div style="float:left; width: 320px;">
                                <label for="nuevaPass" class="label">Nueva contraseña</label>
                                <input type="password" name="nuevaPass" value="" placeholder="Nueva contraseña" class="form-control input-lg" required disabled/>
                            </div>
                           
                             <div style="float:left; width: 320px;">
                                <label for="nuevaPass2" class="label">Repetir contraseña</label>
                                <input type="password" name="nuevaPass2" value="" placeholder="Repetir contraseña" class="form-control input-lg" required disabled/>
                            </div>
                           
                      
                      
                       <div style="float:left; width: 320px; margin-top: 25px;">
                       <span style="width:150px; float:left; margin-right:15px; height:51px; " class="btn-default btn-lg button_generic" onclick="activar1()" >
                               Desbloquear
                          </span>
                       
                         <input type="button"  class="btn-default btn-lg button_generic" style=" width:150px; float:left;" onClick="comprobarClave()" value="Cambiar" disabled>
                            
                        </div>
                    </form>
                    <%}else{ %>
                   <p style="text-align: left"> No es posible cambiar su contraseña, porque se ha conectado mediante LDAP</p>
                    <%} %>
                    </div>
             </div>
                  
                    
                </article>
               
            </div>
        </div>
    </section>
	<!-- end cambiarContrasena -->

<%
String cambiarContrasena = (String)sesion.getAttribute("cambiarContrasena");

if(cambiarContrasena!=null){
	if(cambiarContrasena.equals("1")){ 
		sesion.setAttribute("cambiarContrasena", null); %>
	
	<script type="text/javascript">
	  alert("Contraseña cambiada correctamente\nSu sesion se cerrara\nVuelva a iniciar sesion");
	</script>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=CerrarSesion">
	<%
}else{%>
	<script type="text/javascript">
	  alert("Fallo al modificar contraseña");
	</script>
	<%
}sesion.setAttribute("cambiarContrasena", null);}
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
<%}else {%>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=index.jsp">
<%}}%>