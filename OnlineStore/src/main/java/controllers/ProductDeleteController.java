package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.ProductDao;

/**
 * Servlet implementation class ProductDeleteController
 */
@WebServlet("/admin/productdelete")
public class ProductDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("product");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(request.getParameter("useridtodel"));
		String path = "/media/msi/Secondary/JavaEE/Workspace/ServletJSPWorkspaceTom9/OnlineStore/src/main/webapp/productImg/";
		String filename = new ProductDao().getProductByID(id).getImage();
		File file = new File(path+filename);
		if (new ProductDao().deleteProduct(id)) {
			if (!filename.equals("")) {
				if (file.exists()) {
					if (file.delete()) {
						request.setAttribute("success", "Deleted successfully...");
						request.getRequestDispatcher("product.jsp").forward(request, response);
					}else {
						request.setAttribute("error", "File delete failed!");
						request.getRequestDispatcher("product.jsp").forward(request, response);
					}
				}else {
					request.setAttribute("error", "Image file does not exist!");
					request.getRequestDispatcher("product.jsp").forward(request, response);
				}
			}else {
				request.setAttribute("success", "Deleted successfully...");
				request.getRequestDispatcher("product.jsp").forward(request, response);
			}
			
		}else {
			request.setAttribute("error", "Failed in delete query!");
			request.getRequestDispatcher("product.jsp").forward(request, response);
		}
	}

}
