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
import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class CifradoMD5 {

	public static String md5(String s) {

		String r = null;
		try {
			if (s != null) {
	
				MessageDigest algorithm =MessageDigest.getInstance("MD5");
				algorithm.reset();
				algorithm.update(s.getBytes());
				byte bytes[] = algorithm.digest();
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < bytes.length; i++) {
					String hex = Integer.toHexString(0xff & bytes[i]);
					if (hex.length() == 1)
						sb.append('0');
					sb.append(hex);
				}
			
					r = sb.toString();
			}
		} catch (NoSuchAlgorithmException e) {
		}

		return r;

		}
}