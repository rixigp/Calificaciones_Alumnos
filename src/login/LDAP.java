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

import java.sql.SQLException;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import bbdd.GestorBBDD;
	/**
	* Class to handle authentication through LDAP
	* @version $Revision: 1.2 $
	* @author Abelardo Pardo
	*/

public class LDAP {
private static final String uidPlaceHolder = "@ASAPUID@";
private static final String defaultSearchFilter="(uid="+uidPlaceHolder+ ")";
private String provider_url;
private String basedn;
private String version;
private String securityProtocol;

GestorBBDD gestor = new GestorBBDD();

public LDAP() {
	String datos [] = new String[4];
	try{
		datos = gestor.datosLDAP();
		provider_url 	 = datos[0];
		basedn 		 	 = datos[1];
		version 	 	 = datos[2];
		securityProtocol = datos[3];
	
	} catch (SQLException e) {
		e.printStackTrace();
	}
}


/**
* Given a uid, fetch the object data from LDAP using the default filter
*
* @param uid String to search for
*
* @return SearchResult an object with the requested uid or null if not
* found
*
* @throws Exception if error during searcyh
*
*/
public SearchResult searchUID(String uid) throws Exception {
	return searchUID(uid, defaultSearchFilter);
}

/**
* Given a uid, fetch the object data from LDAP with the given filter
*
* @param uid String to search for
*
* @param filter String to use for filtering
*
* @return SearchResult an object with the requested uid or null if not
* found
*
* @throws Exception if error during searcyh
*
*/

public SearchResult searchUID(String uid, String filter) throws Exception {
	Hashtable env = new Hashtable();
	// Create the environment
	env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
	env.put(Context.PROVIDER_URL, provider_url);
	// If a security protocol has been given, use it
	if (securityProtocol != null) {
	env.put(Context.SECURITY_PROTOCOL, securityProtocol);
	}
	// If a version value has been given, use it
	if (version != null) {
	env.put("java.naming.ldap.version", version);
	}
	
	// A null or empty filter is not a valid option
	if ((filter == null) || ("".equals(filter))) {
	filter = defaultSearchFilter;
	}
	DirContext ctx = new InitialDirContext(env);
	SearchControls constraints = new SearchControls();
	constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
	NamingEnumeration results = ctx.search(basedn,
	filter.replaceFirst(uidPlaceHolder, uid),
	constraints);
	SearchResult sr = null;
	// If the obtained result object is not empty, fetch the first data
	if (results.hasMore()) {
	sr = (SearchResult) results.next();
	}
	ctx.close();
	return sr;
}

/**
* Given an LDAP user object, send credentials to authenticate
*
* @param sr LDAP user previously obtained
*
* @param key password given by the user
*
* @return boolean Indicates the success of the authentication
*
* @throws Exception if authentication fails
*/
public boolean authenticate(SearchResult sr, String key) throws Exception {
	Hashtable env = new Hashtable();
	// Create the environment
	env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
	env.put(Context.PROVIDER_URL, provider_url);
	// If a security protocol has been given, use it
	if (securityProtocol != null) {
	env.put(Context.SECURITY_PROTOCOL, securityProtocol);
	}
	// If a version value has been given, use it
	if (version != null) {
	env.put("java.naming.ldap.version", version);
	}
	env.put(Context.SECURITY_AUTHENTICATION, "simple");
	env.put(Context.SECURITY_PRINCIPAL, sr.getName() + "," + basedn);
	env.put(Context.SECURITY_CREDENTIALS, key);
	DirContext ctx = new InitialDirContext(env);
	
	// If an exception has not happened, the authentication has
	// succeeded
	ctx.close();
	return true;
}
public boolean authenticateUID(String uid, String key) throws Exception {
	return authenticateUID(uid, key, defaultSearchFilter);
}

public boolean authenticateUID(String uid, String key, String filter) throws Exception {
	Hashtable env = new Hashtable();
	// Create the environment
	env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
	env.put(Context.PROVIDER_URL, provider_url);
	// If a security protocol has been given, use it
	if (securityProtocol != null) {
	env.put(Context.SECURITY_PROTOCOL, securityProtocol);
	}
	// If a version value has been given, use it
	if (version != null) {
	env.put("java.naming.ldap.version", version);
	}
	// A null or empty filter is not a valid option
	if ((filter == null) || ("".equals(filter))) {
	filter = defaultSearchFilter;
	}
	DirContext ctx = new InitialDirContext(env);
	SearchControls constraints = new SearchControls();
	constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
	NamingEnumeration results = ctx.search(basedn,
	filter.replaceFirst(uidPlaceHolder, uid),
	constraints);
	SearchResult sr = null;
	// If the obtained result object is not empty, fetch the first data
	if (results.hasMore()) {
	sr = (SearchResult) results.next();
	}
	if (sr == null) return false; // usr does not exist
	env.put(Context.SECURITY_AUTHENTICATION, "simple");
	env.put(Context.SECURITY_PRINCIPAL, sr.getName() + "," + basedn);
	env.put(Context.SECURITY_CREDENTIALS, key);
	try {
	DirContext ctx2 = new InitialDirContext(env);
	// If an exception has not happened, the authentication has
	// succeeded
	ctx2.close();
	}
	catch (Exception e) {
	// password failed
	return false;
	}
	ctx.close();
	return true;
}

} // End of class LDAPHandler