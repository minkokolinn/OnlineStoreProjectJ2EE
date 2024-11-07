package controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.AccountDao;
import models.User;

/**
 * Servlet implementation class AccountUpdate
 */
@WebServlet("/admin/accountupdate")
public class AccountUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountUpdate() {
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
		User user = new User();
		user.setId(Integer.parseInt(request.getParameter("hiddenAccountID")));
		user.setName(request.getParameter("tfName"));
		user.setEmail(request.getParameter("tfEmail"));
		user.setNrc(request.getParameter("tfNrc"));
		user.setPhone(request.getParameter("tfPhone"));
		String dob = request.getParameter("tfDob");
		if (dob.equals("")) {
			dob="";
		} else {
			try {
				Date dateobj = new SimpleDateFormat("yyyy-MM-dd").parse(dob);
				user.setDob(dateobj);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		user.setAddress(request.getParameter("tfAddress"));
		if (request.getParameter("cboAdmin")==null) {
			user.setIsadmin(false);
		}else {
			user.setIsadmin(true);
		}		
		if (new AccountDao().updateUser(user)) {
			request.getRequestDispatcher("account.jsp").forward(request, response);
		}else {
			request.setAttribute("error", "Error in updating user!");
			request.getRequestDispatcher("account.jsp").forward(request, response);
		}
		
	}

}
