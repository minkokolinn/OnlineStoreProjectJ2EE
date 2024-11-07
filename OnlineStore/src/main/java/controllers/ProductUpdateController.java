package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.CategoryDao;
import daos.ProductDao;
import models.Category;
import models.Product;

/**
 * Servlet implementation class ProductUpdateController
 */
@WebServlet("/admin/productupdate")
public class ProductUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		if (request.getParameter("pidtoupd")==null) {
			response.sendRedirect("product");
		}else {
			request.getRequestDispatcher("productupdate.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("tfName");
		String brand = request.getParameter("tfBrand");
		String model = request.getParameter("tfModel");
		String description = request.getParameter("tfDescription");
		int price = Integer.parseInt(request.getParameter("tfPrice"));
		int quantity = Integer.parseInt(request.getParameter("tfQuantity"));
//		Category selectedCategory = new CategoryDao()
//				.getCategoryByID(Integer.parseInt(request.getParameter("cboCategory")));
		
		Product updatedProduct = new Product();
		updatedProduct.setId(Integer.parseInt(request.getParameter("tfProductId")));
		updatedProduct.setName(name);
		updatedProduct.setBrand(brand);
		updatedProduct.setModel(model);
		updatedProduct.setDescription(description);
		updatedProduct.setPrice(price);
		updatedProduct.setQuantity(quantity);
//		updatedProduct.setCategory(selectedCategory);
		
		ProductDao dao = new ProductDao();
		if (dao.updateProduct(updatedProduct)) {
			response.sendRedirect("product");
		}else {
			request.setAttribute("error", "Product update failed!");
			request.getRequestDispatcher("product.jsp").forward(request, response);
		}
	}

}
