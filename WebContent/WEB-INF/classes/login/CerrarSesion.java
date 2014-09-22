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
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bbdd.GestorBBDD;
 

public class CerrarSesion extends HttpServlet {
 
	HttpSession sesion = null;

 
    //Ya sea que el metodo sea por GET o POST, cerraremos la sesion.
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("empiezo cerrar sesion: "+System.currentTimeMillis() );
    	HttpSession sesion = request.getSession(true);
        
        //Cerrar sesion
        sesion.invalidate();
        //se borra la sesion de la cache
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        //Redirecciono a index.jsp
        System.out.println("fin cerrar sesion: "+System.currentTimeMillis() );
        response.sendRedirect("index.jsp");
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}