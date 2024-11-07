package daos;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.OrderDetail;

public class OrderDetailDao {
	private final String PERSISTENCE_UNIT_NAME = "onlinestore";
	private final EntityManagerFactory factory;
	private final EntityManager em;

	public OrderDetailDao() {
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = factory.createEntityManager();
	}
	
	public boolean insertOrderDetail(OrderDetail od) {
		try {
			em.getTransaction().begin();
			em.persist(od);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			em.close();
			e.printStackTrace();
			return false;
		}
	}
}
