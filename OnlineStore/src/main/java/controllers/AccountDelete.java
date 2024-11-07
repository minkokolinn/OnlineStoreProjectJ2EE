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
 * Servlet implementation class AccountDelete
 */
@WebServlet("/admin/accountdelete")
public class AccountDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("account");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int useridtodel = Integer.parseInt(request.getParameter("useridtodel"));
		AccountDao dao = new AccountDao();
		if (dao.deleteUser(useridtodel)) {
			request.getRequestDispatcher("account.jsp").forward(request, response);
		}else {
			request.setAttribute("error", "Error in account delete!!!");
			request.getRequestDispatcher("account.jsp").forward(request, response);
		}
	}

}
