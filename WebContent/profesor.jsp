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

 <%@ page import='java.util.Vector' %>
 <%@ page import='java.util.Iterator' %>

<% 
HttpSession sesion = request.getSession(true);

String ultimaSesion = (String) sesion.getAttribute("ultimaSesion"); 
if(ultimaSesion==null) response.sendRedirect("index.jsp");

if(ultimaSesion!=null){
if(ultimaSesion.equals("")) ultimaSesion = "Nunca";


//para redigirir al usuario correctamente
String tipoUsuario = (String) sesion.getAttribute("tipoUsuario"); 

if (tipoUsuario == null) tipoUsuario="0";//Si no hay usuario le llevamos a index


if(tipoUsuario.equals("profesor")){
	String nombre = (String) sesion.getAttribute("nombre");
	String email = (String) sesion.getAttribute("email");



%>
<!doctype html>
<html lang="es">
<head>
	<!-- Define Charset -->
	<meta charset="UTF-8">
	
	<!-- Page Title -->
	<title>Calificaciones Alumnos - Profesor</title>
    
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
	           
	             <li class="active"><a href="profesor.jsp">Asignaturas</a></li>
	             <li><a href="#cargar_calificaciones">Cargas notas</a></li>
	             <li ><a href="perfil.jsp">Perfil usuario</a></li>
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
        String login = (String) sesion.getAttribute("login"); 
        System.out.println("empiezo visualizar notas: "+System.currentTimeMillis() );
        String [] asignaturas = gestor.buscarAsignaturasProfesor(login); 
        int i;
        for( i = 0; i<asignaturas.length; i++){ 
        %>
            
  		<li style="padding: 10px 15px;"><a href="#<%=asignaturas[i].replaceAll(" ", "") %>"><%=asignaturas[i] %></a></li>
        <%} %>
        <%if (asignaturas.length==0){ %>
        <li style="padding: 10px 15px;">Sin asignaturas</li>
        <%} %>
                                    </ul>
        
                        </div>
                    </section>
	<!-- Features -->
	
	<!-- end Features -->
  <% for( i = 0; i<asignaturas.length; i++){
	  
	  
	  Vector<String> calificacion = new Vector<String>();
	  calificacion = gestor.buscarCalificacionAlumnos(asignaturas[i]); //listamos calificaciones por asignatura

	  int m = 0;
	 
	  int alumnos = calificacion.size()/2;
	 %>
      
      
      
	<!-- Calificaciones -->
     <section  id="<%=asignaturas[i].replaceAll(" ", "")%>"  class="price generic">
        <div class="container text-center">
	
            <div class="row">
                <article class="item col-xs-12 ">
                    
                    <div class="pricely-chart pricely-professional">
                     <ul class="list-group">
	                                <li class="list-group-item" style="padding: 0; border: 0; background-color: transparent; "><span class="feature-hide" style=" font-size: 20px; color: #8495a5; letter-spacing: 1px; text-transform: uppercase; "><b><%=asignaturas[i]%></b></span></li>
	                                   </ul>
						 <ul class="pricely-pro" style="list-style:none;">
                            <li class="pricely-first-heading panel-default col-md-3">
                           
                                <div class="panel-heading" style="height: 66px; padding-top: 15px;">
                                 <span class="pricely-label " style="font-size: 25px;"><%=asignaturas[i]%></span>
                                 </div>
                                 
                                 <div class="panel-heading"  style="height: 26px; border-top: 0;">
	                                 <div style="float:left; width: 50%; margin-top: -15px;"><span style="font-size: 18px;">NOMBRE</span></div>
	                                 <div style="float:left; width: 50%; margin-top: -15px;"><span style="font-size: 18px;">NIA</span></div>
                                 </div>
                                  <ul class="list-group">
                                  
                                
	      							<% while (m<calificacion.size()){ 
	      								
	      								//Desencriptamos nombre de alumno
	      								String nombre_alumno = calificacion.elementAt(m);
										String[] parts = nombre_alumno.split(" ");
										String part1 = parts[0];  
										
										//Desencriptamos NIA de alumno
										String nia_alumno = calificacion.elementAt(m+1);
										String[] parts2 = nia_alumno.split(" ");
										String part2 = parts2[0]; 
										
										%>
	  
                                    <li class="list-group-item">
 									  <div style="float:left; width: 50%;"><span style="font-size: 13px;"><%=part1 %></span></div>
	                                  <div style="float:left; width: 50%;"><span style="font-size: 13px;"><%=part2 %></span></div>
                                    </li>
                               <% m=m+11; } %>
                               </ul>
                            </li>
							 
                            <li class="pricely-inner panel-info col-xs-12 col-md-3">
                            
                                <div class="panel-heading">
                                 <span class="pricely-button"> <a class="btn btn-lg btn-info"><i class=""></i> 1º Cuatrimestre</a></span>				   
                                </div>
                                
                                 <div class="panel-heading"  style="height: 26px; border-top: 0;">
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Teoría 1</span></div>
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Teoría 2</span></div>
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Problema</span></div>
                                 </div>
                                
                                <ul class="list-group">
                                <% m=2; while (m<calificacion.size()){ %>
                                    <li class="list-group-item">
 									  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m) %></span></div>
	                                  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m+1) %></span></div>
	                                  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m+2)  %></span></div>
                                    </li>
                                <% m=m+11; } %>
                                </ul>
                            </li>

                            <li class="pricely-inner panel-danger col-xs-12 col-md-3">
                                 <div class="panel-heading">
                                   <span class="pricely-button"> <a class="btn btn-lg btn-danger">2º Cuatrimestre</a></span>
                                </div>
                                <div class="panel-heading"  style="height: 26px; border-top: 0;">
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Teoría 1</span></div>
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Teoría 2</span></div>
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Problema</span></div>
                                 
                                 </div>

                              <ul class="list-group">
                                     <% m=5; while (m<calificacion.size()){ %>
                                    <li class="list-group-item">
 									  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m) %></span></div>
	                                  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m+1) %></span></div>
	                                  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m+2)  %></span></div>
                                    </li>
                                <% m=m+11; } %>
                                </ul>
                            </li>

                            <li class="pricely-inner panel-success col-xs-12 col-md-3">
                                <div class="panel-heading">
                                   <span class="pricely-button"><a  class="btn btn-lg btn-success">3º Cuatrimestre</a></span>
                                </div>
                               <div class="panel-heading"  style="height: 26px; border-top: 0;">
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Teoría 1</span></div>
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Teoría 2</span></div>
	                                 <div style="float:left; width: 33%; margin-top: -15px;"><span style="font-size: 15px;">Problema</span></div>
                                 
                                 </div>

                                 <ul class="list-group">
                                    <% m=8; while (m<calificacion.size()){ %>
                                    <li class="list-group-item">
 									  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m) %></span></div>
	                                  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m+1) %></span></div>
	                                  <div style="float:left; width: 33%;"><span style="font-size: 13px;"><%=calificacion.elementAt(m+2)  %></span></div>
                                    </li>
                                <% m=m+10; } %>
                                </ul>
                            </li>
                        </ul>
                        
                        <%if (alumnos==0) { %>
                        <p>Sin alumnos asignados</p>
	                    <% } %>
	                   <a id="enlace_<%=asignaturas[i].replaceAll(" ", "")%>" href="descargarCSV.jsp?idAsignatura=<%=asignaturas[i].replaceAll(" ", "")%>" > Descargas notas en CSV -> </a>
	                  <input required="required" placeholder="C:\Alumnos" type="text" id="direccion_<%=asignaturas[i].replaceAll(" ", "")%>" name="direccion_<%=asignaturas[i].replaceAll(" ", "")%>"  onchange="document.links.enlace_<%=asignaturas[i].replaceAll(" ", "")%>.href='descargarCSV.jsp?idAsignatura=<%=asignaturas[i]%>&direccion_<%=asignaturas[i].replaceAll(" ", "")%>='+this.value">
	                  
	          	</div>
       
                </article>

            </div>
        </div>
    </section>
	<!-- end Information -->


  <%} System.out.println("fin visualizar notas: "+System.currentTimeMillis() );%>
  
  <section  id="cargar_calificaciones"  class="price generic" style="padding-top: 30px; ">
        <div class="container text-center" >
	
            <div class="row" style="padding-top: 20px; border-top: 1px solid #ddd; margin: 0 auto; width: 600px;">
          	   <div class="panel-heading" style="height: 66px; padding-top: 15px;">
                    <span class="pricely-label " style="font-size: 25px;">Cargar calificaciones de alumnos</span>
               </div>
                	 <form  enctype="multipart/form-data" action="cargarCSV.jsp" method="post">
					   <table style="width:100%">
					   		<tr>
					   		<td width="15%" style="text-align: left;">Asignatura</td>
		                 	 <td style="text-align: left;">
		                 	 <select required="required" id="carga_asignatura" name="carga_asignatura">
		                 	<%  for( i = 0; i<asignaturas.length; i++){ %>
								  <option value="<%=asignaturas[i] %>"><%=asignaturas[i] %></option>
							<%} %>
								</select>
							</td>
		                  </tr>
		                  <tr> <td></td>
		                 	 <td style="font-size:11px;"><input required="required" name="file" type="file"></td>
		                  </tr>
						  <tr>
						  	<td colspan="2"><p align="left" style="padding-top:15px">
						  		<input type="submit"  value="Cargar CSV" ></p>
						  	</td>
						 </tr>
             		   </table> 
					</form>
          	<p style="float:left;">Modelo de carga -> <a href="archivos/modeloCSV.csv">Descargar</a></p>
             </div>
        </div>
 </section>


<% 
String cargado = (String)sesion.getAttribute("cargado");


if(cargado!=null){
	if(cargado.equals("1")){ 
		 %>
	
	<script type="text/javascript">
	  alert("Alumnos cargados correctamente!");
	</script>
	<%}else if(cargado.equals("2")){ 
		sesion.setAttribute("cargado", null); %> 
	<script type="text/javascript">
	  alert("Alumnos no asignados a esta asignatura!\nSe ha cortado la carga\nAvise al administrador");
	</script> 
	<%}else if(cargado.equals("3")){ 
		sesion.setAttribute("cargado", null); %> 
	<script type="text/javascript">
	  alert("Alguno de los usuario asignado no es alumno!\nSe ha cortado la carga\nAvise al administrador");
	</script> 
	<%}else if(cargado.equals("0")){ 
		sesion.setAttribute("cargado", null); %> 
	<script type="text/javascript">
	  alert("Fallo al cargar alumnos!");
	</script> 
	<%} 
	sesion.setAttribute("cargado", null);}%>
	
<%
String descargado = (String)sesion.getAttribute("descargado");
if(descargado!=null){
	if(descargado.equals("1")){ %>

	<script type="text/javascript">
	  alert("Asignatura descargada correctamente!");
	</script>
	
	<%}else if(descargado.equals("0")){ 
		sesion.setAttribute("descargado", null);%>
	
	<script type="text/javascript">
	  alert("Fallo al descargar asignatura!");
	</script>
	<%}
	sesion.setAttribute("descargado", null); } %>
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
	<meta HTTP-EQUIV="REFRESH" CONTENT="0;URL=index.jsp">

<%}else if (tipoUsuario.equals("alumno")){%>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=alumno.jsp">
<%}else if (tipoUsuario.equals("admin")){%>
	<META HTTP-EQUIV="REFRESH" CONTENT="0;URL=herramientas.jsp">
<%}}%>