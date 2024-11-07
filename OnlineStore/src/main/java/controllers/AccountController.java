package controllers;

import java.io.IOException;
import java.io.PrintWriter;
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
import utility.Utility;

/**
 * Servlet implementation class AccountController
 */
@WebServlet("/admin/account")
public class AccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("account.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("tfName");
		String email = request.getParameter("tfEmail");
		String password = request.getParameter("tfPassword");
		String confirmpassword = request.getParameter("tfConfirmPassword");
		String nrc = request.getParameter("tfNrc");
		String phone = request.getParameter("tfPhone");
		String dob = request.getParameter("tfDob");
		String address = request.getParameter("tfAddress");
		String isadmin = request.getParameter("cboAdmin");
		PrintWriter pw = response.getWriter();
		if (name.equals("") || email.equals("") || password.equals("") || confirmpassword.equals("")) {
			request.setAttribute("error", "Requried fields are empty!!!");
			request.getRequestDispatcher("account.jsp").forward(request, response);
		}else {
			if (password.equals(confirmpassword)) {
				User user = new User();
				user.setName(name);
				user.setEmail(email);
				user.setPassword(Utility.encryptPasswordMD5(confirmpassword));
				user.setNrc(nrc);
				user.setPhone(phone);
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
				user.setAddress(address);
				if (isadmin==null) {
					user.setIsadmin(false);
				}else {
					user.setIsadmin(true);
				}
				AccountDao dao = new AccountDao();
				if (dao.insertAccount(user)) {
					request.getRequestDispatcher("account.jsp").forward(request, response);
				} else {
					request.setAttribute("error", "Error in creating account!!!");
					request.getRequestDispatcher("account.jsp").forward(request, response);
				}
			}else {
				request.setAttribute("error", "Password and Confirm Password must the the same!");
				request.getRequestDispatcher("account.jsp").forward(request, response);
			}
		}
		
	}

}
