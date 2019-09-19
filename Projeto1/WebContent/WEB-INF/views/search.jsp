<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pesquisa</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style type="text/css">
.userInformation{
    position: fixed;
    bottom: 0px;
    left: 0px;
    right: 0px;
    height: 2.3rem;
    background-color: #4DA3FF;
    margin-top: 50rem;
 	padding: 0.3rem;
}
.piece-hr{
 	width: 20%;
}
</style>
</head>
<body>
<%@ page import="java.util.*,me.caiohf.controller.*, me.caiohf.model.*" %>
		<div class="container-fluid mt-3">
		<div class="row text-center">
		<div class="col-md-12">
			<h1 class="display-4">Organizador de tarefas</h1>
			<hr class="piece-hr mb-5">
			<a href="showPage" class="btn btn-primary btn-lg mb-5">Voltar</a>
			</div>
		</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<%
				 DAO dao = new DAO();
				 List<Tasks> tasks = dao.getTasksSearched(request.getParameter("wordSearch"));
				 for (Tasks task : tasks ) {%>
				<div class="col-md-3">
				 <div class="card mb-5 border-primary">
				  <div class="card-body">
				    <h5 class="card-title text-center">Tarefa <%=task.getId()%></h5>
				    <h6 class="card-subtitle mb-2 text-muted">Criador: <%=task.getCreator()%></h6>
				    <p class="card-text">Tarefa: <%=task.getText()%></p>
				    <a>Data: <%=(task.getDay().get(Calendar.DAY_OF_MONTH)+1) + "/" + (task.getDay().get(Calendar.MONTH)+1) + "/" + task.getDay().get(Calendar.YEAR)%></a>
			    	<br>
			    	<a>Categoria: <%=task.getCategory()%></a>
				  </div>
				</div>
				</div>
				 <%}%>
			</div>
	</div>
	<div class=" text-center userInformation">
		<p style="color: white; letter-spacing: 2px;">Usuário: <%=request.getSession().getAttribute("username") %></p>
	</div>
</body>
</html>