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

import javax.naming.directory.SearchResult;
import javax.naming.directory.Attributes;
import javax.naming.directory.Attribute;

public class Autenticacion extends HttpServlet {
	
	String error;
	String nombre;
	String email;
	
	String ultimaSesion = "";
	String datosLDAP="";
	String usuario= "";
	String password= "";
	String tipoUsuario= "";
	String tipoConexion= "";
	
	GestorBBDD gestor = null;

	LDAP manejador= null;
	boolean comprobacion = false;
	HttpSession sesion = null;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// El mtodo doGet llama a doPost
		response.sendRedirect("index.jsp");
		//seguridad antihackers
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("Empieza autenticacion: "+System.currentTimeMillis()); 
		usuario=request.getParameter("usuario");
		password=request.getParameter("password");
		tipoUsuario=request.getParameter("tipo");
		tipoConexion=request.getParameter("conexion");
		
		gestor = new GestorBBDD();
	
		
		if(usuario.equals("100074797")) tipoUsuario="profesor";
		
		try{
			
			if(tipoConexion.equals("ldap")){
				
				manejador= new LDAP ();
		
				/* Obtenemos el objeto searchResult asociado al usuario para obtener su nombre completo */
				SearchResult sr= manejador.searchUID(usuario);
				
				Attributes atributosLDAP= sr.getAttributes();
			
				//Extraemos el nombre completo del alumno
				Attribute atributoNombre=atributosLDAP.get("cn");	
				Attribute atributoMail=atributosLDAP.get("mail");	
				
				
				if (atributoNombre!=null) 
					nombre = (String)atributoNombre.get();
				else 
					nombre = usuario;
				
				//Cogemos el mail del usuario
				email = (String)atributoMail.get();
				
				//Proceso de autenticacion. Se usa el mtodo authenticate
				if(manejador.authenticate(sr,password)) {
					
					//Autenticacion correcta. Creamos sesion y establecemos atributos de sesin
					sesion = request.getSession(true);
					sesion.setAttribute("login",usuario);
					sesion.setAttribute("nombre",nombre);
					sesion.setAttribute("email",email);
					sesion.setAttribute("tipoUsuario",tipoUsuario);
					sesion.setAttribute("tipoConexion",tipoConexion);
	
					//La sesion expira a los 30 minutos.
					sesion.setMaxInactiveInterval(1800);
					
					
					comprobacion = gestor.buscarUser(usuario);
					
					if (!comprobacion)				
						gestor.anadirUsuario(usuario, nombre, email, tipoUsuario);
					else
						ultimaSesion = 	gestor.actualizarUsuario(usuario);
	
					sesion.setAttribute("ultimaSesion",ultimaSesion);
					System.out.println("salgo de ldap "+System.currentTimeMillis() );
					//En otro caso iremos a profesor.jsp o alumno.jsp dependiendo del rol
					if(tipoUsuario.equals("alumno")) 
						response.sendRedirect("alumno.jsp");
					else if(tipoUsuario.equals("profesor")) 
						response.sendRedirect("profesor.jsp");
					else if(tipoUsuario.equals("admin")) 
						response.sendRedirect("herramientas.jsp");
					else 
						response.sendRedirect("index.jsp");
						
				
				}
				
			}else if(tipoConexion.equals("local")){
				
				sesion = request.getSession(true);
				
				try {
					
					comprobacion = gestor.buscarUser(usuario,password,tipoUsuario); //comprobamos que el usuario existe
					
					if(comprobacion!=false)
						ultimaSesion = 	gestor.actualizarUsuario(usuario);
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				if(comprobacion !=false){
					
					sesion.setAttribute("login",usuario);
				
					String [] datosLocal = new String[2];
					datosLocal = gestor.datosLocal(usuario);
					
					sesion.setAttribute("nombre",datosLocal[0]);
					sesion.setAttribute("email",datosLocal[1]);
					sesion.setAttribute("tipoUsuario",tipoUsuario);
					sesion.setAttribute("tipoConexion",tipoConexion);
					
					//La sesion expira a los 30 minutos.
					sesion.setMaxInactiveInterval(1800);
					
					sesion.setAttribute("ultimaSesion",ultimaSesion);
					System.out.println("salgo de local "+System.currentTimeMillis() );
					if(tipoUsuario.equals("alumno")) 
						response.sendRedirect("alumno.jsp");
					else if (tipoUsuario.equals("profesor")) 
						response.sendRedirect("profesor.jsp");
					else if (tipoUsuario.equals("admin")) 
						response.sendRedirect("herramientas.jsp");
					
					//Redirigimos al usuario
					//rd.forward(request,response);
					//response.sendRedirect("herramientas.jsp");
				
				}else{
					error="1";
					RequestDispatcher rd = null;
					request.setAttribute("error",error);
					
					rd=request.getRequestDispatcher("index.jsp");
					rd.forward(request,response);
				}
	
			}
		}catch (Exception e) {
			
			/* Si salta una excepcin, la autenticacin es invlida. Creamos un aviso y redigirimos a la pgina principal */
			error="1";
			RequestDispatcher rd = null;
			request.setAttribute("error",error);
			
			rd=request.getRequestDispatcher("index.jsp");
			rd.forward(request,response);
		}
	
	}//doPost end
}//class end