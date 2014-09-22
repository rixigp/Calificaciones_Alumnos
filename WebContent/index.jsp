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
String tipoUsuario="";
String nombre="";
if(ultimaSesion!=null){
if(ultimaSesion.equals("")) ultimaSesion = "Nunca";


nombre = (String) sesion.getAttribute("nombre"); 
tipoUsuario = (String) sesion.getAttribute("tipoUsuario"); 
if (tipoUsuario == null) tipoUsuario="0";//Si no hay usuario le llevamos a index


}

%>
<!doctype html>
<html lang="es">
<head>
	<!-- Define Charset -->
	<meta charset="UTF-8">
	
	<!-- Page Title -->
	<title>Calificaciones Alumnos - Login</title>
    
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
	          <ul class="menu navbar-nav navbar-right" style="list-style:none; margin-top: 15px;">
	            <li class="active"><a href="index.jsp">Home</a></li>
	            <% if( tipoUsuario.equals("alumno") || tipoUsuario.equals("profesor") ) {%>
	             <li><a href=<%=tipoUsuario %>.jsp>Asignaturas</a></li>
	           <%} %>
	           <%if(tipoUsuario.equals("admin")){%>
	             <li><a href=herramientas.jsp>Herramientas</a></li>
	           <%} %>
	           <%if(ultimaSesion!=null){ %>
	           	<li><a href="perfil.jsp">Perfil usuario</a></li>
	           	<%} %>
	            <li><a href="#menu-contact">Contacto</a></li>
	            <%if(ultimaSesion!=null){ %>
                <li><a href="CerrarSesion">Cerrar sesión</a></li>	
                	<%} %>
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
            <div class="content_slider">
                <!-- slider -->
                <div class="bs-example">
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="img/slide1.jpg" alt="First slide">
                            </div>
                            <div class="item">
                                <img src="img/slide2.jpg" alt="Second slide">
                            </div>
                            <div class="item">
                                <img src="img/slide3.jpg" alt="Third slide">
                            </div>
                        </div>
                        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right"></span>
                        </a>
                    </div>
                </div>
            </div>
            <!-- /slider -->

            <!-- form -->
            <div class="content_form text-center">
            <%
           
            if(ultimaSesion!=null){
          
            %>
	            <h2 class="title">
	                        Bienvenido
	            </h2>
	             <div style="color:#fff" class="form-group input-group-lg">
	                   <%=nombre %>
	                   <p style="margin-top: 20px;">Ultima sesión: <%=ultimaSesion%></p>
	             </div>
            <%}else{ %>
                    <h2 class="title">
                        Login
                    </h2>
                   
  						
                    <h4 style="color: #ffffff;">
                    <% String error = (String) request.getAttribute("error"); 
                    
                    if(error != null){ %>
                    Error de autenticacion
                    <%}%>
                    
                    </h4>
                        <form role="form" action="Autenticacion" method="post">
                            <fieldset>
                                <div class="form-group input-group-lg">
                                    <input class="form-control" placeholder="Usuario" name="usuario" type="text" required >
                                </div>
                                <div class="form-group input-group-lg">
                                    <input class="form-control" placeholder="Contraseña" name="password" type="password" required>
                                </div>
                                <div class="form-group input-group-lg">
                                    <select class="form-control" name="tipo">
                                        <option value="alumno">Alumno</option>
                                        <option value="profesor">Profesor</option>
                                        <option value="admin">Administrador</option>
                                    </select>
                                </div>
                                 <div class="form-group input-group-lg">
                                 <p>Tipo conexión</p>
                                    <select class="form-control" name="conexion">
                                        <option value="ldap">LDAP</option>
                                        <option value="local">Local</option>
                                    </select>
                                </div>
                                <div class="form-group input-group-lg">
                                    <button type="submit" class="btn btn-default btn-lg button_generic">
                                        <i class="icon-paper-plane"></i> Conectar
                                    </button>
                                </div>
                            </fieldset>

                        </form>
                        
            <%}%>
            </div>
            <!-- /form -->
            
            
        </div>
	</section>
	<!-- end Slider and Form -->


	<!-- Features -->
	<section id="menu-features" class="features">

        <article class="item text-center">
            <div class="panel-heading">
               <h3 class="sub_title">
                   <a href="#">Conectate desde cualquier lugar</a>
               </h3>
            </div>
            <div class="panel-body">
                <a href="#" class="content_info">
                   <i class="icon-globe"></i>
                </a>
            </div>
        </article>

        <article class="item text-center">
            <div class="panel-heading">
                <h3 class="sub_title">
                    <a href="#">Calificaciones del profesor</a>
                </h3>
            </div>
            <div class="panel-body">
                <a href="#" class="content_info">
                    <i class="icon-pencil"></i>
                </a>
            </div>
        </article>

        <article class="item text-center">
            <div class="panel-heading">
                <h3 class="sub_title">
                    <a href="#">Compatible con cualquier dispositivo</a>
                </h3>
            </div>
            <div class="panel-body">
                <a href="#" class="content_info">
                    <i class="icon-monitor"></i>
                </a>
            </div>
        </article>

        <article class="item text-center">
            <div class="panel-heading">
                <h3 class="sub_title">
                    <a href="#">Presupuesto para tu centro escolar</a>
                </h3>
            </div>
            <div class="panel-body">
                <a href="#" class="content_info">
                    <i class="icon-credit-card"></i>
                </a>
            </div>
        </article>

        <article class="item text-center">
            <div class="panel-heading">
                <h3 class="sub_title">
                    <a href="#">Para todos los alumnos</a>
                </h3>
            </div>
            <div class="panel-body">
                <a href="#" class="content_info">
                    <i class="icon-user"></i>
                </a>
            </div>
        </article>

	</section>
	<!-- end Features -->



	<!-- Contact -->
	<section id="menu-contact" class="contract generic" style="padding-bottom: 20px;">
        <div class="container text-center">
            <div class="row">
        
                <h2>Formulario de contacto </h2>
                <p>Si deseas ponerte en contacto con nosotros, puedes hacerlo a traves de este formulario </p>
                <div class="col-xs-12 col-lg-10 col-lg-offset-1">
                    <form id="contact" class="form" role="form" action="#" method="post" accept-charset="utf-8">
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="fisrt_name" class="label">Nombre</label>
                                <input id="fisrt_name" type="text" name="name" value="" class="form-control input-lg" placeholder="Nombre"  />
                            </div>
                            <div class="col-xs-12 col-md-6 col-lg-6">
                                <label for="last_name" class="label">Apellidos</label>
                                <input id="last_name" type="text" name="lastname" value="" class="form-control input-lg" placeholder="Apellidos"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6">
                                <label for="last_name" class="label">Email</label>
                                <input type="email" name="email" value="" class="form-control input-lg" placeholder="Email"  />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label for="last_name" class="label">Telefono</label>
                                <input type="tel" name="phone" value="" class="form-control input-lg" placeholder="Telefono"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-md-6">
                                <label for="last_name" class="label">Empresa</label>
                                <input type="text" name="company" value="" class="form-control input-lg" placeholder="Compañia"  />
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <label for="last_name" class="label">Codigo postal</label>
                                <input type="text" name="zip" value="" class="form-control input-lg" placeholder="Codigo postal"  />
                            </div>
                        </div>
                        <div class="content_button">
                            <button class="btn-default btn-lg button_generic" type="submit">
                                <i class="icon-paper-plane"></i>
                                Contactar
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
	</section>
	<!-- end Contact -->







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