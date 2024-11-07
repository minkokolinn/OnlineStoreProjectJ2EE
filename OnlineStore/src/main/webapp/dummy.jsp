<%@page import="java.text.SimpleDateFormat"%>
<%@page import="models.Category"%>
<%@page import="models.User"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Structuring Database</title>
</head>
<body>
	<%
		final String PERSISTENCE_UNIT_NAME="onlinestore";
		final EntityManagerFactory factory;
		final EntityManager em;
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		
		em = factory.createEntityManager();
		
		em.getTransaction().begin();
		User user = new User();
		user.setName("Min Ko Ko Linn");
		user.setEmail("min@gmail.com");
		user.setPassword("07105a4643a5c133207afd3ccd98badc");
		user.setNrc("12/DAGATA(N)095794");
		user.setPhone("09254325731");
		user.setDob(new SimpleDateFormat("yyyy-MM-dd").parse("03-28-2002"));
		user.setAddress("yangon");
		user.setIsadmin(true);
		
		em.persist(user);
		em.getTransaction().commit();
		
		em.close();
	%>
</body>
</html>