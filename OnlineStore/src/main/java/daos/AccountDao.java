package daos;

import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.User;
import utility.Utility;

public class AccountDao {
	private final String PERSISTENCE_UNIT_NAME = "onlinestore";
	private final EntityManagerFactory factory;
	private final EntityManager em;

	public AccountDao() {
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = factory.createEntityManager();
	}

	public boolean insertAccount(User user) {
		try {
			em.getTransaction().begin();
			em.persist(user);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			em.close();
			e.printStackTrace();
			return false;
		}
	}

	public List<User> getAllUsers() {
		em.getTransaction().begin();
		Query query = em.createQuery("select u from User u");
		List<User> list = query.getResultList();
		em.close();
		return list;
	}

	public boolean deleteUser(int id) {
		try {
			em.getTransaction().begin();
			User user = em.find(User.class, id);
			em.remove(user);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			em.close();
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateUser(User newUser) {
		try {
			em.getTransaction().begin();
			User user = em.find(User.class, newUser.getId());
			user.setName(newUser.getName());
			user.setEmail(newUser.getEmail());
			user.setNrc(newUser.getNrc());
			user.setPhone(newUser.getPhone());
			user.setDob(newUser.getDob());
			user.setAddress(newUser.getAddress());
			user.setIsadmin(newUser.isIsadmin());
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
	}

	public User getUserByID(int id) {
		em.getTransaction().begin();
		User user = em.find(User.class, id);
		em.close();
		return user;
	}

	public String doAdminLogin(String email, String password, HttpServletResponse response) {
		String result = "";
		em.getTransaction().begin();
		Query getuser = em.createQuery("select u from User u where u.email='" + email + "'");
		List<User> userlist = getuser.getResultList();
		if (userlist.size() == 1) {
			User u = userlist.get(0);
			if (u.getPassword().equals(Utility.encryptPasswordMD5(password))) {
				if (u.isIsadmin()) {
					Cookie adminLogin = new Cookie("adminLogin", String.valueOf(u.getId()));
					adminLogin.setMaxAge(60 * 60 * 24);
					response.addCookie(adminLogin);
					result = "success";
				} else {
					result = "fail admin";
				}
			} else {
				result = "fail password";
			}
		} else {
			result = "fail email";
		}
		em.close();
		return result;
	}

	public String doUserLogin(String email, String password, HttpServletResponse response) {
		String result = "";
		em.getTransaction().begin();
		Query getuser = em.createQuery("select u from User u where u.email='" + email + "'");
		List<User> userlist = getuser.getResultList();
		if (userlist.size() == 1) {
			User u = userlist.get(0);
			if (u.getPassword().equals(Utility.encryptPasswordMD5(password))) {
				Cookie userLogin = new Cookie("userLogin", String.valueOf(u.getId()));
				userLogin.setMaxAge(60 * 60 * 24);
				response.addCookie(userLogin);
				result = "success";
			} else {
				result = "fail password";
			}
		} else {
			result = "fail email";
		}
		em.close();
		return result;
	}
	
	public int checkAdminAuth(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for(Cookie cookie:cookies) {
				if (cookie.getName().equals("adminLogin")) {
					return Integer.parseInt(cookie.getValue());
				}
			}
		}
		return 0;
	}

	public int checkUserAuth(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for(Cookie cookie:cookies) {
				if (cookie.getName().equals("userLogin")) {
					return Integer.parseInt(cookie.getValue());
				}
			}
		}
		return 0;
	}
	
	public void logoutAdmin(HttpServletRequest request,HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for(Cookie cookie:cookies) {
				if(cookie.getName().equals("adminLogin")) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
		}
	}
	
	public void logoutUser(HttpServletRequest request,HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for(Cookie cookie:cookies) {
				if (cookie.getName().equals("userLogin")) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
		}
	}
	
	public void logoutAll(HttpServletRequest request,HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie:cookies) {
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	}
}
