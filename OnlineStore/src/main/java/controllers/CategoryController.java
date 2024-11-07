package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.CategoryDao;
import models.Category;

/**
 * Servlet implementation class CategoryController
 */
@WebServlet("/admin/category")
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.getRequestDispatcher("category.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (!request.getParameter("tb_category").equals("")) {
			Category category = new Category();
			category.setCategory(request.getParameter("tb_category"));
			category.setDescription(request.getParameter("tb_description"));
			CategoryDao categoryDao = new CategoryDao();
			if (categoryDao.insertCategory(category)) {
				request.getRequestDispatcher("category.jsp").forward(request, response);
			}else {
				request.setAttribute("error", "Error in insert query!");
				request.getRequestDispatcher("category.jsp").forward(request, response);
			}
		}else {
			request.setAttribute("error", "Category field is empty");
			request.getRequestDispatcher("category.jsp").forward(request, response);
		}
		
	}
	
	

}
