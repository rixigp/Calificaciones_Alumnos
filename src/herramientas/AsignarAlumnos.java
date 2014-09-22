/*# Copyright (C) 2014 Carlos III University of Madrid


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
# author: Ricardo Garcia-Prieto (100073317@alumnos.uc3m.es)
# tutor: Pablo Basanta (pbasanta@it.uc3m.es)
#
*/
package herramientas;
import java.io.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import javax.servlet.*;
import javax.servlet.http.*;

import bbdd.GestorBBDD;

import javax.naming.directory.SearchResult;
import javax.naming.directory.Attributes;
import javax.naming.directory.Attribute;

public class AsignarAlumnos extends HttpServlet {
	
	HttpSession sesion = null;
	GestorBBDD gestor = null;

	String [] asignaturas = null;
	String [] alumnos = null;
	int idAlumno = 0;
	int idAsignatura = 0;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//seguridad antihackers
		response.sendRedirect("index.jsp");
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("empiezo asig alum: "+System.currentTimeMillis() );

		sesion = request.getSession(true);
		gestor = new GestorBBDD();
		
		
		try{
			asignaturas = gestor.listarAsignaturas();
			gestor.vaciarAsignarAlumnos();
			 
		  for( int i = 0; i<asignaturas.length; i++){  
			
			 alumnos = request.getParameterValues(asignaturas[i]);
			 
			 if(alumnos != null){
					for(int loopIndex = 0; loopIndex < alumnos.length; loopIndex++){ 
					 idAlumno = gestor.idUsuario(alumnos[loopIndex]);
					 idAsignatura = gestor.idAsignatura(asignaturas[i]);
				
					 gestor.asignarAlumnos(idAsignatura, idAlumno);
				 }
			 }
		  
			
		  }
		
		  gestor.alumnosSinAsignar();
		
		  sesion.setAttribute("asignarAlumnos", "1");	
		
		} catch (SQLException e) { 
			sesion.setAttribute("asignarAlumnos", "0");	
		    System.err.println(e.getMessage()); 
		    
		} 
		System.out.println("fin asig alum: "+System.currentTimeMillis() );

		response.sendRedirect("herramientas.jsp");
				
	}//doPost end
}//class end