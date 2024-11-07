package daos;

import java.awt.SystemColor;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Order;

public class OrderDao {
	private final String PERSISTENCE_UNIT_NAME = "onlinestore";
	private final EntityManagerFactory factory;
	private final EntityManager em;

	public OrderDao() {
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = factory.createEntityManager();
	}
	
	public int insertOrder(Order order) {
		try {
			em.getTransaction().begin();
			em.persist(order);
			em.getTransaction().commit();
			int id = order.getId();
			em.close();
			return id;
		} catch (Exception e) {
			em.close();
			e.printStackTrace();
			return 0;
		}
	}
	
	public Order getOrderByID(int id) {
		em.getTransaction().begin();
		Order order = em.find(Order.class, id);
		em.close();
		return order;
	}
	
	public List<Order> getAllOrders(){
		em.getTransaction().begin();
		Query query = em.createQuery("select o from Order o order by o.orderdate desc");
		List<Order> orderList = query.getResultList();
		em.close();
		return orderList;
	}
	
	public boolean makeDeliver(int id) {
		try {
			em.getTransaction().begin();
			Order order = em.find(Order.class, id);
			order.setIsdelivered(true);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
	}
	
	public boolean deleteOrder(int id) {
		try {
			em.getTransaction().begin();
			Order order = em.find(Order.class, id);
			em.remove(order);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
	}
}
