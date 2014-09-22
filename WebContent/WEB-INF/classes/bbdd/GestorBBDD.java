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
package bbdd;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.*;
import java.util.Date;
import java.util.Vector;
import java.io.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.servlet.http.Cookie;


public class GestorBBDD {

	String clave = "calificacionAlumno";
	CifradoDES encrypter = new CifradoDES(clave);
	CifradoMD5 encrypter2 = new CifradoMD5();
	
    /**
	 * Metodo que nos proporciona la conexion con la bbdd
	 * @return retorna una conexion
	 */
	public Connection dataBase() {
        
		Context initCtx;
		Connection conexion = null;
		try {
			initCtx = new InitialContext();
			//Anadir mysql-connector-java-5.0.8-bin.jar en /Tomcat/lib
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource) envCtx.lookup("jdbc/calificacionesAlumnos");
			conexion = ds.getConnection();
		} catch (NamingException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conexion;
		
        
	}

	/**
	 * Traemos datos LDAP
	 */
	public String [] datosLDAP() throws SQLException {
		String [] resultado = new String[4];
		try{
		Connection conexion = dataBase();
		Statement s = conexion.createStatement();
		ResultSet rs = s.executeQuery("SELECT * FROM datosLDAP");
			
		rs.next();
			
		resultado[0] = rs.getString("provider_url");
		resultado[1] = rs.getString("basedn");
		resultado[2] = rs.getString("version");
		resultado[3] = rs.getString("securityProtocol");
		
		
		conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! datosLDAP "); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public void modificarLDAP(String provider_url, String basedn, String version, String securityProtocol) throws SQLException {
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
	
			ResultSet rs = s.executeQuery("SELECT provider_url FROM datosLDAP ");
			rs.next();
			String bbdd = rs.getString("provider_url");
			
			s.executeUpdate("UPDATE datosLDAP SET provider_url = '"+provider_url+"', basedn = '"+basedn+"', version = '"+version+"', securityProtocol = '"+securityProtocol+"'  WHERE provider_url='"+bbdd+"' LIMIT 1");
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! ModificarLDAP "); 
            System.err.println(e.getMessage()); 
        }
	}
    
	public String [] datosLocal(String login) throws SQLException {
		String [] resultado = new String[2];
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			login = encrypter.encrypt(login);
			
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios WHERE login = '"+login+"'");
				
			rs.next();
				
			resultado[0] = encrypter.decrypt(rs.getString("nombreUsuario"));
			resultado[1] = encrypter.decrypt(rs.getString("email"));
				
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! datosLocal "); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}

	/**
	 * Metodo que nos dice si el usuario existe en la bbdd
	 * @param usuario sera el alias del usuario que buscamos en la base de datos
	 * @param password	comprobamos que la contrasena tambien coincida
	 * @return	retornamos true si esta en la bbdd y false si no
	 * @throws SQLException
	 */
	public boolean buscarUser(String usuario,String password, String tipoLDAP)throws SQLException {
		boolean resultado = false;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios");
			
			System.out.println(usuario);
			System.out.println(password);
			System.out.println(tipoLDAP);
			
			usuario = encrypter.encrypt(usuario);
			password = encrypter2.md5(password);
			tipoLDAP = encrypter.encrypt(tipoLDAP);
			
			System.out.println(usuario);
			System.out.println(password);
			System.out.println(tipoLDAP);
			
			while (rs.next()){
			
				if(usuario.compareTo(rs.getString("login"))==0 )
					if(password.compareTo(rs.getString("pass"))==0)
						if(tipoLDAP.compareTo(rs.getString("tipo"))==0)
							resultado = true;
					
			}
			System.out.println("resultado: "+resultado);
			conexion.close();	
		} catch (Exception e) { 
	        System.err.println("Got an exception! buscarUser"); 
	        System.err.println(e.getMessage()); 
	    }
		return resultado;
	}


	/**
	 * Metodo que nos busca solo el alias del user
	 * @param usuario alias que buscaremos
	 * @return retornamos un String que cambia dependiendo de si lo encontramos o no
	 * @throws SQLException
	 */
	public boolean buscarUser(String usuario)throws SQLException {
		boolean resultado = false;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios");
			
			usuario = encrypter.encrypt(usuario);
			
			while (rs.next()){
				
				if(usuario.compareTo(rs.getString("login"))==0 )
						resultado = true;
					}
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! buscarUser "); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String buscarEmail(String usuario)throws SQLException {
		
		String email = "";
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios where login='"+encrypter.encrypt(usuario)+"'");
			
			rs.next();
				
			email = rs.getString("email");
			email = encrypter.decrypt(email);		
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! buscarEmail "); 
            System.err.println(e.getMessage()); 
        }
		return email;
	}
	
	/**
	 * Metodo que usamos para registrar un user nuevo en la bbdd
	 * @param nombre nombre del usuario que ira en la bbdd
	 * @param alias	nombre con el que se conocera al usuario en la web
	 * @param password la clave de la cuenta del usuario
	 * @return	retornamos true si se crea bien o false si se crea mal
	 * @throws SQLException
	 */
	
	
	public boolean anadirUsuario(String login,String nombreUsuario,String email, String tipo) throws SQLException{
		
	
		boolean resultado = true;
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);	
	
			login = encrypter.encrypt(login);
			nombreUsuario = encrypter.encrypt(nombreUsuario);
			email = encrypter.encrypt(email);
			tipo = encrypter.encrypt(tipo);
			
			s.executeUpdate("INSERT INTO Usuarios (login, nombreUsuario, email, tipo,fechaCreacion) VALUES ('"+login+"','"+nombreUsuario+"','"+email+"','"+tipo+"','"+currentTime+"')");
			
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios where login = '"+login+"'");
			rs.next();
			tipo = encrypter.decrypt(tipo);
			Statement s2 = conexion.createStatement();
			if(tipo.equals("profesor"))
				s2.executeUpdate("INSERT INTO profesores (login) VALUES ('"+rs.getString("idUsuario")+"') ");
			if(tipo.equals("alumno"))
				s2.executeUpdate("INSERT INTO alumnos (login) VALUES ('"+rs.getString("idUsuario")+"') ");
			
			conexion.close();
			
		} catch (Exception e) { 
            System.err.println("Got an exception! anadirUsuario "); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
		
	}
	
	public boolean anadirUsuarioLocal(String login,String nombreUsuario,String email, String tipo) throws SQLException{
		boolean resultado = true;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);	
			
			String pass = "*"+login+"*";
			
			login = encrypter.encrypt(login);
			nombreUsuario = encrypter.encrypt(nombreUsuario);
			email = encrypter.encrypt(email);
			tipo = encrypter.encrypt(tipo);
			
			pass = encrypter2.md5(pass);

			s.executeUpdate("INSERT INTO Usuarios (login, pass, nombreUsuario, email, tipo,fechaCreacion) VALUES ('"+login+"', '"+pass+"','"+nombreUsuario+"','"+email+"','"+tipo+"','"+currentTime+"')");
			
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios where login = '"+login+"'");
			rs.next();
			tipo = encrypter.decrypt(tipo);
			Statement s2 = conexion.createStatement();
			if(tipo.equals("profesor"))
				s2.executeUpdate("INSERT INTO profesores (login) VALUES ('"+rs.getString("idUsuario")+"') ");
			if(tipo.equals("alumno"))
				s2.executeUpdate("INSERT INTO alumnos (login) VALUES ('"+rs.getString("idUsuario")+"') ");
			
			conexion.close();
			
		} catch (Exception e) { 
            System.err.println("Got an exception! anadirUsuarioLocal"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
		
	}
	
	public String actualizarUsuario(String login) throws SQLException{
		String resultado = "";
		try{
		Connection conexion = dataBase();
		Statement s = conexion.createStatement();
		login = encrypter.encrypt(login);
		
		ResultSet rs = s.executeQuery("SELECT * FROM Usuarios WHERE login='"+login+"'");
		
		rs.next();
		resultado  = rs.getString("ultimoLogon");
		Date dNow = new Date( );
	      SimpleDateFormat ft1 = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss ");
		
		s.executeUpdate("UPDATE Usuarios SET ultimoLogon='"+ft1.format(dNow)+"' WHERE login='"+login+"'");
		
		conexion.close();
		
		} catch (Exception e) { 
            System.err.println("Got an exception! actualizarUsuario"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
		
	}
	
	
	/**
	 * Metodo que nos sirve para saber el id de un usuario en la bbdd
	 * @param user el alias del usuario que buscamos
	 * @return retornamos el id del usuario
	 * @throws SQLException
	 */
	public int idUsuario (String login)throws SQLException {
		
		int id = 0;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			ResultSet rs = s.executeQuery("SELECT idUsuario FROM Usuarios where login='"+encrypter.encrypt(login)+"'");
			rs.next();
			id = rs.getInt("idUsuario");
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! idUsuario"); 
            System.err.println(e.getMessage()); 
        }
		return id;
	}
	
	
	public String loginUsuario (String idUsuario) throws SQLException {
		
		String nombre = "";
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios where idUsuario='"+idUsuario+"'");
			
			rs.next();
			nombre = rs.getString("login");
			
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! loginUsuario"); 
            System.err.println(e.getMessage()); 
        }
		return nombre;
	}
	
	public int idProfesor (int idProfesor)throws SQLException {
		
		int id = 0;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			ResultSet rs = s.executeQuery("SELECT idProfesor FROM profesores where login='"+idProfesor+"'");
			
			rs.next();
			id = rs.getInt("idProfesor");
			
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! idProfesor"); 
            System.err.println(e.getMessage()); 
        }
		return id;
	}
	
	public int idAsignatura (String asignatura) throws SQLException {
		
		int id = 0;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			ResultSet rs = s.executeQuery("SELECT IdAsignatura FROM asignatura where NombreAsignatura='"+encrypter.encrypt(asignatura)+"'");
			rs.next();
			id = rs.getInt("IdAsignatura");
			
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! idAsignatura"); 
            System.err.println(e.getMessage()); 
        }
		return id;
	}
	
	public void crearAsignatura(String asignatura, int idProfesor) throws SQLException{
		boolean resultado = true;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			s.executeUpdate("INSERT INTO asignatura (NombreAsignatura,IdProfesor) VALUES ('"+encrypter.encrypt(asignatura)+"','"+idProfesor+"')");
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! crearAsignatura"); 
            System.err.println(e.getMessage()); 
        }
	}
	
	public String [] buscarAsignaturas(String login)throws SQLException {
		System.out.println(login);
		int idAlumno = idUsuario(login);
		String asignaturaID = "";
		String asignaturaNombre = "";
		String [] resultado = null;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			Statement s3 = conexion.createStatement();
			
			ResultSet rs3 = s.executeQuery("SELECT COUNT(*) FROM calificaciones where IdAlumno = '"+idAlumno+"'");
			rs3.next();
		    int rowCount = rs3.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM calificaciones where IdAlumno = '"+idAlumno+"'");
			
			int i = 0;
			while (rs.next()){
				asignaturaID = rs.getString("idAsignatura");
				ResultSet rs2 = s2.executeQuery("SELECT * FROM asignatura where IdAsignatura = '"+asignaturaID+"'");	
				
				rs2.next();
				resultado[i] = encrypter.decrypt(rs2.getString("NombreAsignatura"));
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! buscarAsignaturas"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] listarAsignaturas () throws SQLException {
		
		
		String asignaturaID = "";
		String asignaturaNombre = "";
		String [] resultado = null;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			Statement s3 = conexion.createStatement();
			
			ResultSet rs3 = s.executeQuery("SELECT COUNT(*) FROM asignatura ");
			rs3.next();
		    int rowCount = rs3.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM asignatura");
			
			int i = 0;
			while (rs.next()){
				asignaturaID = rs.getString("idAsignatura");
				ResultSet rs2 = s2.executeQuery("SELECT * FROM asignatura where IdAsignatura = '"+asignaturaID+"'");	
				
				rs2.next();
				resultado[i] = encrypter.decrypt(rs2.getString("NombreAsignatura"));
				
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! listarAsignaturas"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] listarProfesores () throws SQLException {
		
		String [] resultado = null;
		
		try{
			
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			
			ResultSet rs2 = s.executeQuery("SELECT COUNT(*) FROM Usuarios where tipo='"+encrypter.encrypt("profesor")+"' ");
			rs2.next();
		    int rowCount = rs2.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios where tipo='"+encrypter.encrypt("profesor")+"' ");
			
			int i = 0;
			while (rs.next()){
			
				resultado[i] = encrypter.decrypt(rs.getString("login"));
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! listarProfesores"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] listarAlumnos () throws SQLException {
		
		String [] resultado = null;
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			
			ResultSet rs2 = s.executeQuery("SELECT COUNT(*) FROM Usuarios where tipo='"+encrypter.encrypt("alumno")+"' ");
			rs2.next();
		    int rowCount = rs2.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios where tipo='"+encrypter.encrypt("alumno")+"' ");
			
			int i = 0;
			while (rs.next()){
				
				resultado[i] = encrypter.decrypt(rs.getString("login"));
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! listarAlumnos"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] listarUsuarios () throws SQLException {
		
		String [] resultado = null;
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			
			ResultSet rs2 = s.executeQuery("SELECT COUNT(*) FROM Usuarios WHERE  `pass` !=  'null'");
			rs2.next();
		    int rowCount = rs2.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM Usuarios WHERE  `pass` !=  'null'");
			
			int i = 0;
			while (rs.next()){
				
				resultado[i] = encrypter.decrypt(rs.getString("login"));
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! listarUsuarios"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] profesorActivo () throws SQLException {
		
		String [] resultado = null;
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			String profesorID = "";
			
			ResultSet rs3 = s.executeQuery("SELECT COUNT(*) FROM asignatura ");
			rs3.next();
		    int rowCount = rs3.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM asignatura");
			
			int i = 0;
			while (rs.next()){
				profesorID = rs.getString("IdProfesor");
				ResultSet rs4 = s2.executeQuery("SELECT * FROM profesores where IdProfesor = '"+profesorID+"'");	
				rs4.next();
				
				ResultSet rs2 = s2.executeQuery("SELECT * FROM Usuarios where idUsuario = '"+rs4.getString("login")+"'");	
				rs2.next();
				resultado[i] = encrypter.decrypt(rs2.getString("login"));
				
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! profesorActivo"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] alumnosActivos (String asignatura) throws SQLException {
		
		String [] resultado = null;
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			String profesorID = "";
		
			int idAsignatura = idAsignatura(asignatura);
			
			
			ResultSet rs3 = s.executeQuery("SELECT COUNT(*) FROM asignatura_alumno where IdAsignatura = '"+idAsignatura+"'");
			
			rs3.next();
		    int rowCount = rs3.getInt(1);
		    
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM asignatura_alumno where IdAsignatura = '"+idAsignatura+"'");
			
			int i = 0;
			while (rs.next()){
				ResultSet rs2 = s2.executeQuery("SELECT * FROM Usuarios where idUsuario = '"+rs.getString("IdAlumno")+"'");	
				rs2.next();
				resultado[i] = encrypter.decrypt(rs2.getString("login"));
				
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! alumnosActivos"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public void asignarProfesores (String asignaturas,int idProfesor) throws SQLException {
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
					
			s.executeUpdate("UPDATE asignatura SET IdProfesor='"+idProfesor+"' WHERE NombreAsignatura = '"+encrypter.encrypt(asignaturas)+"' ");
		
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! asignarProfesores"); 
            System.err.println(e.getMessage()); 
        }
	}
	
	public void asignarAlumnos (int idAsignatura,int idAlumno) throws SQLException {
		
		try{
		
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			s.executeUpdate("insert into asignatura_alumno (IdAsignatura,IdAlumno) values ("+idAsignatura+","+idAlumno+")");
			
			ResultSet rs3 = s.executeQuery("SELECT * FROM calificaciones where IdAlumno = '"+idAlumno+"' AND IdAsignatura = '"+idAsignatura+"'");
			boolean existe = rs3.next();
		    
			if(!existe)
				s.executeUpdate("insert into calificaciones (`IdAsignatura`,`IdAlumno`, `1C_teoria1`, `1C_teoria2`, `1C_problema`, `2C_teoria1`, `2C_teoria2`, `2C_problema`, `3C_teoria1`, `3C_teoria2`, `3C_problema`) values("+idAsignatura+","+idAlumno+",0,0,0,0,0,0,0,0,0 )");
			
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! asignarAlumnos"); 
            System.err.println(e.getMessage()); 
        }
	}
	
	public void vaciarAsignarAlumnos() throws SQLException {
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			s.executeUpdate("TRUNCATE TABLE `asignatura_alumno`");
		
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! vaciarAsignarAlumnos"); 
            System.err.println(e.getMessage()); 
        }
		
	}

	
	public void alumnosSinAsignar() throws SQLException {
		
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			
			ResultSet rs = s.executeQuery("SELECT * FROM calificaciones");
			
			while(rs.next()){
			
				int idAlumno = rs.getInt(3);
				int idAsignatura = rs.getInt(2);
				
				ResultSet rs2 = s2.executeQuery("SELECT * FROM asignatura_alumno where IdAlumno = '"+idAlumno+"' AND IdAsignatura = '"+idAsignatura+"'");
				
				boolean existe = false;
				
				existe = rs2.next();
				if(!existe){
					s.executeUpdate("DELETE FROM calificaciones where IdAlumno='"+idAlumno+"' AND IdAsignatura='"+idAsignatura+"'");
					rs = s.executeQuery("SELECT * FROM calificaciones");
				}
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! alumnosSinAsignar"); 
            System.err.println(e.getMessage()); 
        }
		
	}
	
	public String [] buscarCalificacion(String asignatura, String login)throws SQLException {
		
		int idAsignatura = idAsignatura(asignatura);
		int idAlumno = idUsuario(login);
		String [] resultado = null;
		String asignaturaID = "";
		String asignaturaNombre = "";
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			
			
			ResultSet rs3 = s.executeQuery("SELECT * FROM calificaciones where IdAlumno = '"+idAlumno+"' AND IdAsignatura = '"+idAsignatura+"'");
			rs3.next();
		    
		   
			resultado = new String [9];
			
				
			for (int i = 0; i<9; i++){
				resultado[i] = rs3.getString(i+4);
				
			}
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! buscarCalificacion"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public String [] buscarAsignaturasProfesor(String login)throws SQLException {
		
		
		int idProfesor = idUsuario(login);
		
		int idProfesor2 = idProfesor(idProfesor);
		String [] resultado = null;
		String asignaturaID = "";
		String asignaturaNombre = "";
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			Statement s3 = conexion.createStatement();
			
			ResultSet rs3 = s3.executeQuery("SELECT COUNT(*) FROM asignatura where IdProfesor = '"+idProfesor2+"'");
			rs3.next();
		    int rowCount = rs3.getInt(1);
			resultado = new String [rowCount];
			ResultSet rs = s.executeQuery("SELECT * FROM asignatura where IdProfesor = '"+idProfesor2+"'");
			
			int i = 0;
			while (rs.next()){
				asignaturaID = rs.getString("idAsignatura");
				ResultSet rs2 = s2.executeQuery("SELECT * FROM asignatura where IdAsignatura = '"+asignaturaID+"'");	
				
				rs2.next();
				resultado[i] = encrypter.decrypt(rs2.getString("NombreAsignatura"));
				i++;
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! buscarAsignaturasProfesor"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
public Vector<String> buscarCalificacionAlumnos(String asignatura)throws SQLException {
		
	
		int idAsignatura = idAsignatura(asignatura);
		
		Vector<String> vector = new Vector<String>();
	
		String asignaturaID = "";
		String asignaturaNombre = "";
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			Statement s3 = conexion.createStatement();
			
			ResultSet rs3 = s3.executeQuery("SELECT * FROM calificaciones where IdAsignatura = '"+idAsignatura+"'");
		
			while(rs3.next()){
			    
				
				Statement s4 = conexion.createStatement();
				ResultSet rs4 = s4.executeQuery("SELECT * FROM Usuarios where idUsuario='"+rs3.getString(3)+"'");
				rs4.next();
				String a = rs4.getString("nombreUsuario");
				String[] parts = a.split(" ");
				String part1 = parts[0]; 
				
				
				vector.add(encrypter.decrypt(part1));
				vector.add(encrypter.decrypt(rs4.getString("login")));
				vector.add(rs3.getString(4));
				vector.add(rs3.getString(5));
				vector.add(rs3.getString(6));
				vector.add(rs3.getString(7));
				vector.add(rs3.getString(8));
				vector.add(rs3.getString(9));
				vector.add(rs3.getString(10));
				vector.add(rs3.getString(11));
				vector.add(rs3.getString(12));
			}
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! buscarCalificacionAlumnos"); 
            System.err.println(e.getMessage()); 
        }
		return vector;
	}

	public int cargarCSV (String saveFile, String carga_asignatura) throws SQLException {
	
		int resultado = 1;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			Statement s2 = conexion.createStatement();
			Statement s3 = conexion.createStatement();
			Statement s5 = conexion.createStatement();
			ResultSet rs4 = null;
			
			
			int idAsignatura = idAsignatura(carga_asignatura);
			
			
			String[] parts = saveFile.split("\r"); //Separamos alumnos de cada fila
			int longitud = saveFile.split("\r").length;
			int alumno;
			String nombre = "";
			
				for (int i = 0; i<longitud;i++){
					//Cogemos primer dato que es nombre, buscamos primera ; que sera la primera nota.
					alumno = parts[i].indexOf(";");
					nombre = parts[i].substring(0,alumno);
					//Dejamos solo las notas, sin el nombre.
					parts[i] = parts[i].substring(alumno+1);
					
					int idAlumno = idUsuario(nombre);
					
					ResultSet rs5 = s5.executeQuery("SELECT * FROM Usuarios WHERE idUsuario='"+idAlumno+"'");
					rs5.next();
					String tipo = encrypter.decrypt(rs5.getString(6));
				
					if(tipo.equals("alumno")){
						ResultSet rs6 = s.executeQuery("SELECT * FROM asignatura_alumno where IdAlumno='"+idAlumno+"' AND IdAsignatura='"+idAsignatura+"'");
						
						//Alumno existe en la tabla, esta asignado por el administrador
						boolean existe6 = rs6.next();
						
						if(existe6){
						
							rs4 = s.executeQuery("SELECT * FROM calificaciones where IdAlumno='"+idAlumno+"' AND IdAsignatura='"+idAsignatura+"'");
							boolean existe = rs4.next();
							
							//Si la calificacion ya existe, la borramos y anadimos la nueva.
							
							if(existe){
								s2.executeUpdate("DELETE FROM calificaciones where IdAlumno='"+idAlumno+"' AND IdAsignatura='"+idAsignatura+"'");
								s3.executeUpdate("insert into calificaciones (`IdAsignatura`,`IdAlumno`, `1C_teoria1`, `1C_teoria2`, `1C_problema`, `2C_teoria1`, `2C_teoria2`, `2C_problema`, `3C_teoria1`, `3C_teoria2`, `3C_problema`) values("+idAsignatura+","+ idAlumno + "," + parts[i].replace(";", ",")+")");
							}else
								s3.executeUpdate("insert into calificaciones (`IdAsignatura`,`IdAlumno`, `1C_teoria1`, `1C_teoria2`, `1C_problema`, `2C_teoria1`, `2C_teoria2`, `2C_problema`, `3C_teoria1`, `3C_teoria2`, `3C_problema`) values("+idAsignatura+","+ idAlumno + "," + parts[i].replace(";", ",")+")");
						}else
							resultado = 2; //usuarios no asignados por administrador
					}else
						resultado = 3; //usuario no alumno
				}
			conexion.close();
		}catch (Exception e){
			resultado = 0;
			System.err.println(e.getMessage()); 
		}
		
		
		return resultado; 
	}
	
	public int descargarCSV (String nombreAsignatura, String filename) throws SQLException {
		
		Connection conexion = dataBase();
		Statement s = conexion.createStatement();
		
		int idAsignatura = idAsignatura(nombreAsignatura);
		ResultSet rs = s.executeQuery("SELECT * FROM calificaciones where IdAsignatura = '"+idAsignatura+"'");
		
		int resultado = 1;
		
		try	{
			FileWriter fw = new FileWriter(filename);
			fw.append("Alumno");
			fw.append(';');
			fw.append("1C_teoria1");
			fw.append(';');
			fw.append("1C_teoria2");
			fw.append(';');
			fw.append("1C_problema");
			fw.append(';');
			fw.append("2C_teoria1");
			fw.append(';');
			fw.append("2C_teoria2");
			fw.append(';');
			fw.append("2C_problema");
			fw.append(';');
			fw.append("3C_teoria1");
			fw.append(';');
			fw.append("3C_teoria2");
			fw.append(';');
			fw.append("3C_problema");
			fw.append('\n');		
			
			
			while(rs.next()){
				fw.append(encrypter.decrypt(loginUsuario(rs.getString(3))));
				fw.append(';');
				fw.append(rs.getString(4));
				fw.append(';');
				fw.append(rs.getString(5));
				fw.append(';');
				fw.append(rs.getString(6));
				fw.append(';');
				fw.append(rs.getString(7));
				fw.append(';');
				fw.append(rs.getString(8));
				fw.append(';');
				fw.append(rs.getString(9));
				fw.append(';');
				fw.append(rs.getString(10));
				fw.append(';');
				fw.append(rs.getString(11));
				fw.append(';');
				fw.append(rs.getString(12));
				fw.append('\n');
			}
		
			fw.flush();
			fw.close();
		} catch (Exception e) {
			resultado = 0;
		}
		
		conexion.close();
		return resultado;
		
		}

	public int comprobarContrasena (String contrasena, String login) throws SQLException {
		int resultado = 0;
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			
			
			ResultSet rs = s.executeQuery("SELECT pass FROM Usuarios WHERE login = '"+encrypter.encrypt(login)+"' ");
			
			rs.next();
			String passBD = rs.getString("pass");	
			contrasena = encrypter2.md5(contrasena);

			if(contrasena.equals(passBD))
				resultado = 1;
			
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! comprobarContrasena"); 
            System.err.println(e.getMessage()); 
        }
		return resultado;
	}
	
	public void cambiarContrasena (String contrasena, String login) throws SQLException {
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			contrasena = encrypter.encrypt(contrasena);		
			s.executeUpdate("UPDATE Usuarios SET pass='"+contrasena+"' WHERE login = '"+login+"' ");
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! cambiarContrasena"); 
            System.err.println(e.getMessage()); 
        }
	}
	
	public void resetearContrasena (String login) throws SQLException {
		try{
			Connection conexion = dataBase();
			Statement s = conexion.createStatement();
			
			
			String contrasena = "*"+login+"*";
			contrasena = encrypter2.md5(contrasena);
			login = encrypter.encrypt(login);
			
			s.executeUpdate("UPDATE Usuarios SET pass='"+contrasena+"' WHERE login = '"+login+"' ");
			
			conexion.close();
		} catch (Exception e) { 
            System.err.println("Got an exception! resetearContrasena"); 
            System.err.println(e.getMessage()); 
        }
	}
	

}//fin clase