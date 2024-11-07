package daos;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Category;
import models.Product;

public class ProductDao {
	private final String PERSISTENCE_UNIT_NAME = "onlinestore";
	private final EntityManagerFactory factory;
	private final EntityManager em;

	public ProductDao() {
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = factory.createEntityManager();
	}
	
	public boolean insertProduct(Product product) {
		try {
			em.getTransaction().begin();
			em.persist(product);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
		
	}
	
	public List<Product> getAllProducts(){
		em.getTransaction().begin();
		Query query = em.createQuery("select p from Product p");
		List<Product> list = query.getResultList();
		em.close();
		return list;
	}
	
	public Product getProductByID(int id) {
		em.getTransaction().begin();
		Product product=em.find(Product.class, id);
		em.close();
		return product;
	}
	
	public boolean deleteProduct(int id) {
		try {
			em.getTransaction().begin();
			Product product = em.find(Product.class, id);
			em.remove(product);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
	}
	
	public boolean updateProduct(Product updatedProduct) {
		try {
			em.getTransaction().begin();
			Product newProduct = em.find(Product.class, updatedProduct.getId());
			newProduct.setName(updatedProduct.getName());
			newProduct.setBrand(updatedProduct.getBrand());
			newProduct.setModel(updatedProduct.getModel());
			newProduct.setDescription(updatedProduct.getDescription());
			newProduct.setPrice(updatedProduct.getPrice());
			newProduct.setQuantity(updatedProduct.getQuantity());
//			newProduct.setCategory(updatedProduct.getCategory());
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
	}
	
	public boolean updateQuantityForOrder(int pid, int decreasedQty) {
		try {
			em.getTransaction().begin();
			Product updProduct = em.find(Product.class, pid);
			updProduct.setQuantity(updProduct.getQuantity()-decreasedQty);
			em.getTransaction().commit();
			em.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			return false;
		}
	}
	
	public List<Product> getProductsFilter(List<Integer> catIdArr){
		em.getTransaction().begin();
		List<Product> products = new ArrayList<>();
		
		for(int id:catIdArr) {
			Category cat = new CategoryDao().getCategoryByID(id);
			Set<Product> eachProducts = cat.getProducts();
			for(Product p:eachProducts) {
				products.add(p);
			}
		}
		return products;
	}
	
	public List<Product> getRecommended3(){
		em.getTransaction().begin();		
		Query query = em.createQuery("select p from Product p order by p.likecount desc");
		List<Product> list = query.setMaxResults(3).getResultList();
		em.close();
		return list;
	}
	public static void main(String[] args) {
		new ProductDao().getRecommended3();
	}
}
