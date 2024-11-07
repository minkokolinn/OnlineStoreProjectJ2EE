package daos;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Category;

public class CategoryDao {
	private final String PERSISTENCE_UNIT_NAME = "onlinestore";
	private final EntityManagerFactory factory;
	private final EntityManager em;

	public CategoryDao() {
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = factory.createEntityManager();
	}
	
	public boolean insertCategory(Category category) {
		try {
			em.getTransaction().begin();
			em.persist(category);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			em.close();
			e.printStackTrace();
			return false;
		}
	}

	public List<Category> getAllCategories() {
		em.getTransaction().begin();
		Query query = em.createQuery("select c from Category c");
		List<Category> list = query.getResultList();
		em.close();
		return list;
	}
	
	public boolean deleteCategory(int id) {
		try {
			em.getTransaction().begin();
			Category category = em.find(Category.class, id);
			em.remove(category);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			em.close();
			e.printStackTrace();
			return false;
		}
	}
	
	public Category getCategoryByID(int id) {
		em.getTransaction().begin();
		Category category = em.find(Category.class, id);
		em.close();
		return category;
	}
}
