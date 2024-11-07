package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


import daos.CategoryDao;
import daos.ProductDao;
import models.Category;
import models.Product;

/**
 * Servlet implementation class ProductInsertController
 */
@WebServlet("/admin/productadd")
@MultipartConfig
public class ProductInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductInsertController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("productadd.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("tfName");
		String brand = request.getParameter("tfBrand");
		String model = request.getParameter("tfModel");
		String description = request.getParameter("tfDescription");
		int price = Integer.parseInt(request.getParameter("tfPrice"));
		int quantity = Integer.parseInt(request.getParameter("tfQuantity"));
		Category selectedCategory = new CategoryDao()
				.getCategoryByID(Integer.parseInt(request.getParameter("cboCategory")));

		// File Upload
		Part filePart = request.getPart("fileImage");
		String fileName = filePart.getSubmittedFileName();
		String filetype = filePart.getContentType();
		String path = "/media/msi/Secondary/JavaEE/Workspace/ServletJSPWorkspaceTom9/OnlineStore/src/main/webapp/productImg/";
		// -----------------------------------

		if (name.equals("") || brand.equals("") || model.equals("") || description.equals("") || price == 0
				|| quantity == 0 || selectedCategory == null) {
			request.setAttribute("error", "Required fields are missing! Invalid Entry!");
			request.getRequestDispatcher("productadd.jsp").forward(request, response);
		} else {
			if (fileName.equals("")) {
				Product product = new Product();
				product.setName(name);
				product.setBrand(brand);
				product.setModel(model);
				product.setDescription(description);
				product.setPrice(price);
				product.setQuantity(quantity);
				product.setCategory(selectedCategory);
				product.setImage(fileName);
				if (new ProductDao().insertProduct(product)) {
					request.setAttribute("success", "Successfully inserted a product...");
					request.getRequestDispatcher("productadd.jsp").forward(request, response);
				}else {
					request.setAttribute("error", "Failed in inserting product!!!");
					request.getRequestDispatcher("productadd.jsp").forward(request, response);
				}
			} else {
				if (filetype.equals("image/jpeg") || filetype.equals("image/jpg") || filetype.equals("image/png")
						|| filetype.equals("image/webp") || filetype.equals("image/gif")) {
					
					Product product = new Product();
					product.setName(name);
					product.setBrand(brand);
					product.setModel(model);
					product.setDescription(description);
					product.setPrice(price);
					product.setQuantity(quantity);
					product.setCategory(selectedCategory);
					product.setImage(fileName);
					
					if (new ProductDao().insertProduct(product)) {
						for(Part part:request.getParts()) {
							
							String newfilename=getFileName(part);
							if (!newfilename.equals("")) {
								part.write(path+newfilename);
							}
						}
						request.setAttribute("success", "Successfully inserted a product...");
						request.getRequestDispatcher("productadd.jsp").forward(request, response);
					}else {
						request.setAttribute("error", "Failed in inserting product!!!");
						request.getRequestDispatcher("productadd.jsp").forward(request, response);
					}
				} else {
					request.setAttribute("error", "Invalid File Type");
					request.getRequestDispatcher("productadd.jsp").forward(request, response);
				}
			}
		}

	}
	
	private String getFileName(Part part) {
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename"))
	            return content.substring(content.indexOf("=") + 2, content.length() - 1);
	        }
	    return "";
	}

}
