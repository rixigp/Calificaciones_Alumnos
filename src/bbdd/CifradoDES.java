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
import java.security.*;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.KeySpec;

import javax.crypto.*;
import javax.crypto.spec.*;

import sun.misc.CEStreamExhausted;
import sun.misc.CharacterEncoder;
import sun.misc.HexDumpEncoder;

import java.io.*;

public class CifradoDES {

	Cipher ecipher;
	Cipher dcipher;
	
	// 8-byte Salt
	byte[] salt = {
		(byte)0xA9, (byte)0x9B, (byte)0xC8, (byte)0x32,
		(byte)0x56, (byte)0x35, (byte)0xE3, (byte)0x03
	};
	
	// Iteration count
	int iterationCount = 19;
	
	public CifradoDES(String passPhrase) {
		
		try {
			// Create the key
			KeySpec keySpec = new PBEKeySpec(passPhrase.toCharArray(), salt, iterationCount);
			SecretKey key = SecretKeyFactory.getInstance(
			"PBEWithMD5AndDES").generateSecret(keySpec);
			ecipher = Cipher.getInstance(key.getAlgorithm());
			dcipher = Cipher.getInstance(key.getAlgorithm());
			
			// Prepare the parameter to the ciphers
			AlgorithmParameterSpec paramSpec = new PBEParameterSpec(salt, iterationCount);
			
			// Create the ciphers
			ecipher.init(Cipher.ENCRYPT_MODE, key, paramSpec);
			dcipher.init(Cipher.DECRYPT_MODE, key, paramSpec);
			
		} catch (java.security.InvalidAlgorithmParameterException e) {
			System.out.println("EXCEPTION: InvalidAlgorithmParameterException");
		} catch (java.security.spec.InvalidKeySpecException e) {
			System.out.println("EXCEPTION: InvalidKeySpecException");
		} catch (javax.crypto.NoSuchPaddingException e) {
			System.out.println("EXCEPTION: NoSuchPaddingException");
		} catch (java.security.NoSuchAlgorithmException e) {
			System.out.println("EXCEPTION: NoSuchAlgorithmException");
		} catch (java.security.InvalidKeyException e) {
			System.out.println("EXCEPTION: InvalidKeyException");
		}
	}
	
	public String encrypt(String str) {
		
		try {
			// Encode the string into bytes using utf-8
			byte[] utf8 = str.getBytes();
			
			// Encrypt
			byte[] enc = ecipher.doFinal(utf8);
			
			// Encode bytes to base64 to get a string
			return new sun.misc.BASE64Encoder().encode(enc);
			
		} catch (javax.crypto.BadPaddingException e) {
		} catch (IllegalBlockSizeException e) {
		}
		return null;
	}
		
	public String decrypt(String str) {
		try {
			// Decode base64 to get bytes
			byte[] dec = new sun.misc.BASE64Decoder().decodeBuffer(str);
			
			// Decrypt
			byte[] utf8 = dcipher.doFinal(dec);
			
			// Decode using utf-8
			return new String(utf8, "UTF8");
			
		} catch (javax.crypto.BadPaddingException e) {
		} catch (IllegalBlockSizeException e) {
		} catch (UnsupportedEncodingException e) {
		} catch (java.io.IOException e) {
		}
		return null;
	}


}