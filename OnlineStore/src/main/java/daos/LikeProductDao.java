package daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.LikeProduct;
import models.Product;
import models.User;

public class LikeProductDao {
	private final String PERSISTENCE_UNIT_NAME = "onlinestore";
	private final EntityManagerFactory factory;
	private final EntityManager em;

	public LikeProductDao() {
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = factory.createEntityManager();
	}
	
	public int likeAction(int id, User loginedUser) {
		em.getTransaction().begin();
		Product p = em.find(Product.class, id);
		p.setLikecount(p.getLikecount()+1);
		int count = p.getLikecount();
		
		LikeProduct lp = new LikeProduct();
		lp.setUser(loginedUser);
		lp.setProduct(p);
		em.persist(lp);
		
		em.getTransaction().commit();
		em.close();
		return count;
	}
	
	public int UnlikeAction(int id, User loginedUser) {
		em.getTransaction().begin();
		Product p = em.find(Product.class, id);
		p.setLikecount(p.getLikecount()-1);
		int count = p.getLikecount();
		
		Query query = em.createNativeQuery("delete from likeproducts where user_id="+loginedUser.getId()+" and product_id="+id);
		query.executeUpdate();
		
		em.getTransaction().commit();
		em.close();
		return count;
	}
	
	public boolean hasbeenLiked(int user_id, int product_id) {
		em.getTransaction().begin();
		
		Query query = em.createNativeQuery("select * from likeproducts where user_id="+user_id+" and product_id="+product_id);
		List<LikeProduct> list=query.getResultList();
		if (list.size()==1) {
			return true;
		}else {
			return false;
		}
	}
}

