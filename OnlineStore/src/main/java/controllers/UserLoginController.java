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
 * Servlet implementation class UserLoginController
 */
@WebServlet("/login")
public class UserLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (new AccountDao().checkUserAuth(request)==0) {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else {
			response.sendRedirect("/OnlineStore");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String loginEmail = request.getParameter("emailInput");
		String loginPassword = request.getParameter("passwordInput");
		
		if (loginEmail.equals("") || loginPassword.equals("")) {
			request.setAttribute("error", "Some required fields are empty! Please fill in all fields!!!");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else {
			AccountDao dao = new AccountDao();
			String result = dao.doUserLogin(loginEmail, loginPassword, response);
			if (result.equals("fail email")) {
				request.setAttribute("error", "Incorrect admin email !! This account does not exist!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else if(result.equals("fail password")) {
				request.setAttribute("error", "Incorrect admin password !!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else if(result.equals("success")) {
				response.sendRedirect("index.jsp");
			}else {
				request.setAttribute("error", "Invalid !!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}

}
