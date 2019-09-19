<%@page import="org.apache.jasper.JasperException"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Home</title>
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
			<button type="button" class="btn btn-primary btn-lg mr-3 mb-5" id="addButton" data-toggle="modal" data-target="#modalAdd">Adicionar</button>
			<div class="modal fade" id="modalAdd" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header text-center">
		          <h4 class="modal-title">Adicionar tarefa</h4>
		        </div>
		        <div class="modal-body">
		          <form method="post" action="create">
					  <div class="form-group">
					    <label for="taskLabel">Tarefa</label>
					    <input type="text" class="form-control" name="text"  placeholder="Descreva a tarefa">
					  </div>
					  <div class="form-group">
					    <label for="categoryLabel">Categoria</label>
					    <input type="text" class="form-control" name="category" placeholder="Categoria">
					  </div>
					  <div class="form-group">
					    <label for="creatorLabel" class="text-muted">Criador:</label>
					    <input type="text" class="form-control text-center" name="creator" value=<%=request.getSession().getAttribute("username") %> style="border:0; background-color:white;" readonly>
					  </div>
					  <button type="submit" class="btn btn-primary bnt-default">Adicionar</button>
					</form>
		        </div>
		        <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
		        </div>
		      </div>
		    </div>
  			</div>
  			<button type="button" class="btn btn-primary btn-lg mb-5 mr-3" id="editButton" data-toggle="modal" data-target="#modalEdit">Editar</button>
  			<div class="modal fade" id="modalEdit" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header text-center">
		          <h4 class="modal-title">Editar tarefa</h4>
		        </div>
		        <div class="modal-body">
		          <form method="post" action="selectIdToEdit">
					  <div class="form-group">
					    <label for="taskLabel">ID da tarefa: </label>
					    <select name="idSelector" class="form-control">
						  <%DAO dao = new DAO(); 
						  List<Integer> ids = dao.getIds();
						  for(Integer id: ids){%>
						  		<option><%=id%></option>
						<% } %>
						</select>
					  </div>
					  <button type="submit" class="btn btn-primary bnt-default" id="selectIdButton">Selecionar</button>
					</form>
		        </div>
		        <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
		        </div>
		      </div> 
		    </div>
  			</div>
			<button type="button" class="btn btn-primary btn-lg mb-5 mr-3" id="deleteButton" data-toggle="modal" data-target="#modalDelete">Apagar</button>
			<div class="modal fade" id="modalDelete" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header text-center">
		          <h4 class="modal-title">Apagar tarefa</h4>
		        </div>
		        <div class="modal-body">
		          <form method="post" action="delete">
					  <div class="form-group">
					    <label for="taskLabel">ID da tarefa: </label>
					    <select name="id" class="form-control">
						  <option>Selecione o ID</option>
						  <%for(Integer id: ids){%>
						  	<option><%=id%></option>
						  <% } %>
						</select>
					  </div>
					  <div class="form-group">
					    <div class="form-check">
					      <input class="form-check-input" type="checkbox" name="removeCheck" id="removeCheck">
					      <label class="form-check-label" for="removeCheck">
					        Estou ciente de que a ação não poderá ser desfeita.
					      </label>
					    </div>
					  </div>
					  <button type="submit" class="btn btn-primary bnt-default" id="selectIdButtonDelete">Selecionar</button>
					</form>
		        </div>
		        <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
		        </div>
		      </div>
		    </div>
  			</div>
			<button type="button" class="btn btn-primary btn-lg mb-5 mr-3" id="filterButton" data-toggle="modal" data-target="#modalFilter">Filtrar</button>
			<div class="modal fade" id="modalFilter" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header text-center">
		          <h4 class="modal-title">Filtrar tarefas</h4>
		        </div>
		        <div class="modal-body">
		          <form method="post" action="filter">
					  <div class="form-group">
					    <label for="filterLabel">Filtrar por categoria: </label>
					    <select name="category" class="form-control">
						  <option>Selecione a categoria</option>
						   <%
							 List<String> tasksToFilter = dao.getCategorys();
							 for (String taskFilter : tasksToFilter) {%>
							 <option><%=taskFilter%></option>
							 <%} %>
						</select>
					  </div>
					  <button type="submit" class="btn btn-primary bnt-default" id="filterButtonSelect">Aplicar filtro</button>
					</form>
		        </div>
		        <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
		        </div>
		      </div>
		    </div>
  			</div>
  			<button type="button" class="btn btn-primary btn-lg mb-5 mr-3" data-toggle="collapse" data-target="#collapseMetrics" aria-expanded="false" aria-controls="collapseMetrics">Informações</button>
  			<div class="collapse" id="collapseMetrics">
			  <div class="card card-body mb-4">
			  <% Integer tasksSize = 0;
			  try{ tasksSize = dao.getTasksSize(); } catch (ArrayIndexOutOfBoundsException e){ ;}%>
			  <p>Total de tarefas ativas: <%=dao.getTextSize() %></p>
			  <p>Total de tarefas criadas (LifeTime): <%=tasksSize %></p>
			  <p>Total de categorias: <%=tasksToFilter.size() %></p>
			  <p>Total de usuários cadastrados: <%=dao.getUsernameSize()%></p>
			  </div>
			</div>
			<button type="button" class="btn btn-primary btn-lg mb-5 mr-3" id="searchButton" data-toggle="modal" data-target="#modalSearch">Pesquisar</button>
			<div class="modal fade" id="modalSearch" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header text-center">
		          <h4 class="modal-title">Pesquisar</h4>
		        </div>
		        <div class="modal-body">
		          <form method="post" action="search">
					  <div class="form-group">
					    <label for="pesquisaLabel">Pesquisa </label>
					    <input type="text" class="form-control" name="textSearch" placeholder="Palavras-chave">
					  </div>
					  <button type="submit" class="btn btn-primary bnt-default" id="filterButtonSelect">Procurar</button>
					</form>
		        </div>
		        <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
		        </div>
		      </div>
		    </div>
  			</div>
			<a href="logout" class="btn btn-primary btn-lg mb-5">Sair</a>
		</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<% 
			 List<Tasks> tasks = dao.getTasks();
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
			 <%  }%>
		</div>
	</div>
	<div class=" text-center userInformation">
		<p style="color: white; letter-spacing: 2px;">Usuário: <%=request.getSession().getAttribute("username") %></p>
	</div>	
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="script.js" charset="utf-8"></script>
</body>
</html>