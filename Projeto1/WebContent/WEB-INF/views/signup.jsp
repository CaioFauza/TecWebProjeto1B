<%@page import="java.sql.SQLException"%>
<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cadastro</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<%@ page import="java.util.*,me.caiohf.controller.*, me.caiohf.model.*" %>
<div class="container-fluid mt-3">
		<div class="row text-center justify-content-md-center">
			<div class="col-md-12">
				<h1 class="display-4 mb-2">Cadastro</h1>
				<h3 class="display-5 lead mb-5">Por favor, preencha as informações para continuar.</h3>
			</div>
			<form method="post" action="signup">
			<div class="col-md-12">
					  <div class="form-group">
					    <label for="Username">Usuário</label>
					    <input type="text" class="form-control" name="username" placeholder="Nome de usuário">
					  </div>
					  <div class="form-group mt-3">
					    <label for="Password">Senha</label>
					    <input type="password" class="form-control" name="password" placeholder="Senha">
					  </div>
			</div>
			<div class="col-md-12">
				<button type="submit" class="btn btn-primary btn-lg mb-4 mt-4" style="width: 18rem">Cadastrar</button>
			</div>
			</form>
			<div class="col-md-12">
			<form action ="authPage">
				<input type="submit" class="btn btn-primary btn-lg mb-5" value="Voltar" style="width: 18rem"></input>
			</form>
			</div>
			</div>
		
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>