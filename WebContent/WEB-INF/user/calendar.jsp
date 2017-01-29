<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Campanha"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle de Vacinação (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.12.4.js"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-light-grey">
	<div id="menu">
		<ul class="w3-navbar w3-white w3-card-2" id="myNavbar">
			<li><a href="#home" class="w3-wide">SCV</a></li>

			<li class="w3-right w3-hide-small">
				<a href="">CADASTRO</a>
				<a href="">CARTÃO DE VACINAÇÃO</a>
				<a href="">CALENDÁRIO DE VACINAÇÃO</a>
				<a href="/SCV/logout">Sair</a>
			</li>

			<li><a href="javascript:void(0)" class="w3-right w3-hide-large w3-hide-medium" onclick="w3_open()"> <i class="fa fa-bars w3-padding-right w3-padding-left"></i>
			</a></li>
		</ul>
	</div>

	<nav class="w3-sidenav w3-margin-0 w3-white w3-card-2 w3-animate-left w3-hide-medium w3-hide-large" style="display: none" id="mySidenav">
		<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> <a href="" onclick="w3_close()">CARTÃO DE VACINAÇÃO</a> <a href="" onclick="w3_close()">CALENDÁRIO DE VACINAÇÃO</a> <a href="/SCV/logout" onclick="w3_close()">Sair</a>
	</nav>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
	
		List<Campanha> campanhas = CampanhaDAO.getInstance().carregarTodos();
		List<Campanha> campanhasEmAndamento = new ArrayList<Campanha>();
		List<Campanha> campanhasFuturas = new ArrayList<Campanha>();
		List<Campanha> campanhasPassadas = new ArrayList<Campanha>();
		
		Date hoje = new Date();
		
		for (Campanha campanha : campanhas) {
			if (campanha.getDataInicio().compareTo(hoje) <= 0 && campanha.getDataFim().compareTo(hoje) >= 0) {
				campanhasEmAndamento.add(campanha);
			} else if (campanha.getDataInicio().after(hoje)) {
				campanhasFuturas.add(campanha);
			} else if (campanha.getDataFim().before(hoje)) {
				campanhasPassadas.add(campanha);
			}
		}
		
	%>

	<div class="w3-container w3-padding-64">
		<div class="w3-row">
			<div class="w3-col l6">
			  <button onclick="document.getElementById('id01').style.display='block'" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge">Clique para ver o Calendário de Vacinação de 2017</button>
			
			  <div id="id01" class="w3-modal">
			    <div class="w3-modal-content w3-animate-opacity w3-card-8">
			      <header class="w3-container"> 
			        <span onclick="document.getElementById('id01').style.display='none'" class="w3-closebtn">&times;</span>
			      </header>
			      <div class="w3-container">
			        <img src="./resources/calendars/2017.jpg" class="w3-image" alt="Calendário Nacional de Vacinação de 2017">
			      </div>
			    </div>
			  </div>
  			</div>
  			<div class="w3-col l6">
    			<%if (!campanhasEmAndamento.isEmpty()) {%>
					
				<%}%>
				
				<%if (!campanhasFuturas.isEmpty()) {%>
					
				<%}%>
				
				<%if (!campanhasPassadas.isEmpty()) {%>
					
				<%}%>
  			</div>
  		</div>

	</div>
	
	<script src="./resources/scripts/navigation.js"></script>
</body>
</html>
