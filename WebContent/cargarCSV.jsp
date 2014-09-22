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
<%@ page import="java.io.*,java.sql.*" %>
<%@ page import = 'bbdd.GestorBBDD'  %>

<html>
<%
System.out.println("empiezo cargar notas: "+System.currentTimeMillis() );
	String contentType = request.getContentType();
	HttpSession sesion = request.getSession(true);
	
	String ultimaSesion = (String) sesion.getAttribute("ultimaSesion"); 
	String tipoUsuario = (String) sesion.getAttribute("tipoUsuario"); 
	if (tipoUsuario == null) tipoUsuario="0";//Si no hay usuario le llevamos a index

	if(tipoUsuario.equals("profesor")){
	
		if(ultimaSesion==null) response.sendRedirect("index.jsp");
	
		else{
			//here we are checking the content type is not equal to Null and as well as the passed data from mulitpart/form-data is greater than or equal to 0
			if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
			 	DataInputStream in = new DataInputStream(request.getInputStream());
			 	//we are taking the length of Content type data
				int formDataLength = request.getContentLength();
				byte dataBytes[] = new byte[formDataLength];
				int byteRead = 0;
				int totalBytesRead = 0;
				//this loop converting the uploaded file into byte code
				while (totalBytesRead < formDataLength) {
					byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
					totalBytesRead += byteRead;
				}
		
				String file = new String(dataBytes);
				
				
				//for saving the file name
				int carga_asignatura_posicion = file.indexOf("carga_asignatura")+21;
				int carga_asignatura_posicion2 = file.indexOf("------",20)-2;
				String carga_asignatura = file.substring( carga_asignatura_posicion,carga_asignatura_posicion2);
				int problema3 = file.indexOf("3C_problema")+12;
				int webkit = file.indexOf("------",130)-2;
				String saveFile = file.substring( problema3,webkit);
				
				
			    String line = null;
				String value=null;
				
			    StringBuilder contents = new StringBuilder();
					
				GestorBBDD gestor = new GestorBBDD();
				int resultado = gestor.cargarCSV(saveFile,carga_asignatura);
					
					//guardamos atributo en sesion si se ha cargado 
				
			    sesion.setAttribute("cargado", ""+resultado);
			
			    
			    
			}
			System.out.println("fin cargar notas: "+System.currentTimeMillis() );
			 
			
			response.sendRedirect("profesor.jsp");
		}
	}else if(tipoUsuario.equals("alumno"))
			response.sendRedirect("alumno.jsp");
	else if(tipoUsuario.equals("admin"))
		response.sendRedirect("herramientas.jsp");
	%>
	
</html>


