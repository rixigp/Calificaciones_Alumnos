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
<%@ page import = 'bbdd.GestorBBDD'  %>

<html>
<body>
<% 

System.out.println("empiezo descargar notas: "+System.currentTimeMillis() );
	String contentType = request.getContentType();
	HttpSession sesion = request.getSession(true);
	
	String ultimaSesion = (String) sesion.getAttribute("ultimaSesion"); 
	String tipoUsuario = (String) sesion.getAttribute("tipoUsuario"); 
	if (tipoUsuario == null) tipoUsuario="0";//Si no hay usuario le llevamos a index
	
	
	
	
			
	if(tipoUsuario.equals("profesor")){
	
	if(ultimaSesion==null) response.sendRedirect("index.jsp");

		else{
			
			String nombreAsignatura = request.getParameter("idAsignatura");
			String direccion = "";
			
			try{
			  	direccion = request.getParameter("direccion_"+nombreAsignatura.replace(" ", ""));
			
			
			     String filename = direccion+"/"+nombreAsignatura+".csv";
			
		
				GestorBBDD gestor = new GestorBBDD();
				int resultado = gestor.descargarCSV(nombreAsignatura,filename);
						
				//guardamos atributo en sesion si se ha descargado 
				System.out.println("fin descargar notas: "+System.currentTimeMillis() );
				if(resultado==0)
			    	sesion.setAttribute("descargado", "0");
				else
					sesion.setAttribute("descargado", "1");
				 
				 response.sendRedirect("profesor.jsp");
			} catch (Exception e) {
				response.sendRedirect("profesor.jsp");
			}	
			
		}
	}else if(tipoUsuario.equals("alumno"))
		response.sendRedirect("alumno.jsp");
	else if(tipoUsuario.equals("admin"))
		response.sendRedirect("herramientas.jsp");
%>

</body>
</html>