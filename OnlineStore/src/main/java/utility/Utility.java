package utility;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.apache.catalina.startup.ExpandWar;

import daos.AccountDao;
import models.Category;

public class Utility {
	public static String encryptPasswordMD5(String str) {
		MessageDigest m = null;
		try {
			m = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		m.update(str.getBytes());
		byte[] bytes = m.digest();
		
		StringBuilder s = new StringBuilder();
		for (int i = 0; i < bytes.length; i++) {
			s.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
		}
		return s.toString();
	}
	
	public static String generateOrderNumber() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MMdd");
		String prefixDate = formatter.format(new Date());
		
		double d = Math.random()*1000000000;
		String suffixRand = String.valueOf((int) d);
		return prefixDate+"-"+suffixRand;
	}
	
	public static void main(String[] args) {
//		String PERSISTENCE_UNIT_NAME = "onlinestore";
//		EntityManagerFactory factory=Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
//		EntityManager em=factory.createEntityManager();
//		
//		em.getTransaction().begin();
//		Category category = em.find(Category.class, 1);
//		category.setCategory("new mark");
//		em.getTransaction().commit();
//		em.close();
		
//		System.out.println(Utility.encryptPasswordMD5("admin123"));
		
//		0192023a7bbd73250516f069df18b500
		
	}
}
