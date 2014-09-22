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


public class CrearUsuario extends HttpServlet {
	HttpSession sesion = null;
	GestorBBDD gestor = null;
	EnviarMail enviomail = null;
	
	String login="";
	String nombreUsuario="";
	String email="";
	String tipo="";
	String asunto = "";
	String cuerpo = "";
	
	boolean comprobar = false;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// El mtodo doGet llama a doPost
		response.sendRedirect("index.jsp");
		//seguridad antihackers
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("empiezo crear usuario: "+System.currentTimeMillis() );
		
		sesion = request.getSession(true);
		gestor = new GestorBBDD();
		enviomail = new EnviarMail();
		
		login=request.getParameter("login");
		nombreUsuario=request.getParameter("nombreUsuario");
		email=request.getParameter("email");
		tipo=request.getParameter("tipo");
		
		try{
			comprobar = gestor.buscarUser(login);
			
			if(comprobar == false){
			gestor.anadirUsuarioLocal(login,nombreUsuario,email,tipo);
		
			asunto = "Nuevo usuario en el aplicativo web";
			cuerpo = "<p>Bienvenido al sistema de calificaciones web </p>"
					+ "<p>Su usuario es: <b>"+login+"</b></p>"
					+ "<p>Su contrasena es: <b>*"+login+"*</b></p>"
					+ "<p>Su tipo de usuario es: <b>"+tipo+"</b></p>"
					+ "<p>Acceda a esta URL: <b>http://localhost:8080/calificacionAlumno</b></p>"
					+ "<p></p><p>Si tiene alguna pregunta, envienos un correo. </p><p>Gracias</p><p>Un saludo</p>";
			
			
			enviomail.setup(email, asunto, cuerpo);
			
			sesion.setAttribute("crearUsuario", "1");	
			}else
				sesion.setAttribute("crearUsuario", "2");
		} catch (SQLException e) { 
			
			sesion.setAttribute("crearUsuario", "0");
		    System.err.println(e.getMessage()); 
		    	
		} 
		System.out.println("fin crear usuario: "+System.currentTimeMillis() );

		response.sendRedirect("herramientas.jsp");
	
	}//doPost end
	
	
}//class end