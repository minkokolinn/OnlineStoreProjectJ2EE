package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.AccountDao;

/**
 * Servlet implementation class AdminLoginController
 */
@WebServlet("/admin/login")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (new AccountDao().checkAdminAuth(request)==0) {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else {
			response.sendRedirect("dashboard");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("emailInput");
		String password = request.getParameter("passwordInput");
		
		if (email.equals("") || password.equals("")) {
			request.setAttribute("error", "Some required fields are empty! Please fill in all fields!!!");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else {
			AccountDao dao = new AccountDao();
			String result = dao.doAdminLogin(email, password, response);
			if (result.equals("fail email")) {
				request.setAttribute("error", "Incorrect admin email !! This account does not exist!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else if(result.equals("fail password")) {
				request.setAttribute("error", "Incorrect admin password !!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else if(result.equals("fail admin")) {
				request.setAttribute("error", "You are permitted to login as admin. Access Denied !!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else if(result.equals("success")) {
				response.sendRedirect("dashboard");
			}else {
				request.setAttribute("error", "Invalid !!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}

}
