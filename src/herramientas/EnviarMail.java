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
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
 
public class EnviarMail{
	
	String host = ""; // IP del Servidor de Correo
	String username = ""; // Usuario
	String password = ""; // Password
	
	String port = ""; // Puerto para conectar con host de correo
	String hostenvio = ""; // IP del Servidor de Correo de envio

	
	
   public void setup(String para, String asunto, String cuerpo)
   {    
      
      // La direccion de la cuenta de envio (from)
      String de = "r.garciaprietov@gmail.com";
 
   // Configuramos el acceso IMAP al servidor.
   		username = "r.garciaprietov@gmail.com";
   		password = "superixi6";
   		host = "imap.gmail.com";
   		port = "993";
   		hostenvio = "smtp.gmail.com";
 
   		Properties props = System.getProperties();
  		props.put("mail.smtp.host", hostenvio);
  		props.put("mail.smtp.auth", "true");
  		props.put("mail.smtp.starttls.enable", "true");
   		
  		// props.put("mail.smtp.host", "smtp.gmail.com");
   		props.put("mail.smtp.port", "587");
   		props.setProperty("mail.imaps.host", host);
  		props.setProperty("mail.imaps.port", port);
  		props.setProperty("mail.store.protocol", "imaps");
  		props.setProperty("mail.imaps.connectiontimeout", "5000");
  		props.setProperty("mail.imaps.timeout", "5000");
      
      
   
      // Obtenemos la sesion por defecto
      Session sesion = Session.getDefaultInstance(props);
      
 
      try{
         // Creamos un objeto mensaje tipo MimeMessage por defecto.
         MimeMessage mensaje = new MimeMessage(sesion);
 
         // Asignamos el "de o from" al header del correo.
         mensaje.setFrom(new InternetAddress(de));
 
         // Asignamos el "para o to" al header del correo.
         mensaje.addRecipient(Message.RecipientType.TO,
                                  new InternetAddress(para));
 
         // Asignamos el asunto
         mensaje.setSubject(asunto);
 
         // Asignamos el mensaje como tal
         mensaje.setContent(cuerpo, "text/html");
         Transport transport = sesion.getTransport("smtp");

		transport.connect(host, username, password);
         // Enviamos el correo
    
		try {
			transport.sendMessage(mensaje, mensaje.getAllRecipients());
		} catch (NoSuchProviderException e) {
		// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error al enviar mensaje con una de las direcciones indicadas");
			
		}

		transport.close();

		} catch (AddressException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("Error al enviar mensaje con la cuenta de correo enviante");
		} catch (MessagingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("Error al enviar mensaje con el contenido del correo");
					
		}
   }
}