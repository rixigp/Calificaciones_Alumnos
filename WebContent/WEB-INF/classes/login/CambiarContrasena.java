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
#*/
package login;
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
import herramientas.EnviarMail;

import javax.naming.directory.SearchResult;
import javax.naming.directory.Attributes;
import javax.naming.directory.Attribute;

public class CambiarContrasena extends HttpServlet {
	
	HttpSession sesion = null;
	GestorBBDD gestor = null;
	String nuevaPass = "";
	String actualPass = "";
	String login = "";
	String email = "";
	String asunto = "";
	String cuerpo = "";
	EnviarMail enviomail = null;
	int resultado = 0;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// El mtodo doGet llama a doPost
		response.sendRedirect("index.jsp");
		//seguridad antihackers
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		sesion = request.getSession(true);
		login = (String) sesion.getAttribute("login");
		gestor = new GestorBBDD();
		sesion = request.getSession(true);
		
		actualPass=request.getParameter("actualPass");
		nuevaPass=request.getParameter("nuevaPass");
		
		enviomail = new EnviarMail();
		
		try{
			
			resultado = gestor.comprobarContrasena(actualPass, login);
			sesion.setAttribute("cambiarContrasena", "0");
			if(resultado == 1){
				gestor.cambiarContrasena(nuevaPass, login); 
			    sesion.setAttribute("cambiarContrasena", "1");	
			}
		
			email = (String) sesion.getAttribute("email");
			
			asunto = "Contrasena cambiada en el aplicativo web";
			cuerpo = "<p>Incidencia en el sistema de calificaciones web </p>"
					+ "<p>Su usuario: <b>"+login+"</b></p>"
					+ "<p>Ha cambiado la contrasena.</p>"
					+ "<p>Acceda a esta URL: <b>http://localhost:8080/calificacionAlumno</b></p>"
					+ "<p></p><p>Si usted no ha solicitado este cambio, envienos un correo. </p><p>Gracias</p><p>Un saludo</p>";
			
			
			enviomail.setup(email, asunto, cuerpo);
		
		} catch (SQLException e) { 
			sesion.setAttribute("cambiarContrasena", "0");	
		    System.err.println(e.getMessage()); 
		    
		} 
		System.out.println("fin cambio pass: "+System.currentTimeMillis() );
		response.sendRedirect("perfil.jsp");
				
	}//doPost end
}//class end