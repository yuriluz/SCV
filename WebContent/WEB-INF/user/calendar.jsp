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
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle de Vacina��o (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.12.4.js"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

<meta name="description" content="P�gina do Usu�rio do Sistema de Controle de Vacina��o">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">
	<div id="menu">
		<ul class="w3-navbar w3-blue w3-card-2" id="myNavbar">
			<li><a href="#home" style="color: #ffffff;" class="w3-wide">SCV</a></li>

			<li class="w3-right w3-hide-small">
				<a style="color: #ffffff;" href="">CADASTRO</a>
				<a style="color: #ffffff;" href="">CART�O DE VACINA��O</a>
				<a style="color: #ffffff;" href="">CALEND�RIO DE VACINA��O</a>
				<a style="color: #ffffff;" href="/SCV/logout">Sair</a>
			</li>

			<li><a href="javascript:void(0)" class="w3-right w3-hide-large w3-hide-medium" onclick="w3_open()"> <i class="fa fa-bars w3-padding-right w3-padding-left w3-text-white"></i>
			</a></li>
		</ul>
	</div>

	<nav class="w3-sidenav w3-margin-0 w3-blue w3-card-2 w3-animate-left w3-hide-medium w3-hide-large" style="display: none" id="mySidenav">
		<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar �</a> <a href="" onclick="w3_close()">CART�O DE VACINA��O</a> <a href="" onclick="w3_close()">CALEND�RIO DE VACINA��O</a> <a href="/SCV/logout" onclick="w3_close()">Sair</a>
	</nav>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
	
		List<Campanha> campanhas = CampanhaDAO.getInstance().carregarTodasNacionais();
		if (!estado.equals(null)){
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasPorEstado(estado));
		}
		if (!cidade.equals(null)){
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasPorCidade(cidade));
		}
		List<Campanha> campanhasEmAndamento = new ArrayList<Campanha>();
		List<Campanha> campanhasFuturas = new ArrayList<Campanha>();
		List<Campanha> campanhasPassadas = new ArrayList<Campanha>();
		
		Date hoje = new Date();
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
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

	<div class="w3-container w3-center w3-padding-64 w3-margin">
		<div class="w3-row">
		  	<div class="w3-col l6">
    			<%if (!campanhasEmAndamento.isEmpty()) {%>
    			<div>
					<h6>Campanhas em andamento:</h6>
					<hr class="w3-margin-0 w3-margin-bottom">
					<div class="w3-accordion w3-light-grey">
					<% for (Campanha campanha : campanhasEmAndamento) { %>
						<button style="white-space: normal;" onclick="myFunction('<%=campanha.getCodigo()%>')" class="w3-btn-block w3-left-align w3-blue"><%=campanha.getNome()%> - De <%=df.format(campanha.getDataInicio())%> at� <%=df.format(campanha.getDataFim())%> <i class="fa fa-caret-down"></i></button>
						<div id="<%=campanha.getCodigo()%>" class="w3-accordion-content w3-container">
      						<p><i><%=campanha.getDescricao()%></i></p>
    					</div>
					<% } %>
					</div>
				</div>
				<% } %>
				
				<%if (!campanhasFuturas.isEmpty()) {%>
				<div class="w3-margin-top">
					<h6>Pr�ximas campanhas:</h6>
					<hr class="w3-margin-0 w3-margin-bottom">
					<div class="w3-accordion w3-light-grey">
					<% for (Campanha campanha : campanhasFuturas) { %>
						<button style="white-space: normal;" onclick="myFunction('<%=campanha.getCodigo()%>')" class="w3-btn-block w3-left-align w3-blue"><%=campanha.getNome()%> - De <%=df.format(campanha.getDataInicio())%> at� <%=df.format(campanha.getDataFim())%> <i class="fa fa-caret-down"></i></button>
						<div id="<%=campanha.getCodigo()%>" class="w3-accordion-content w3-container">
      						<p><i><%=campanha.getDescricao()%></i></p>
    					</div>
					<% } %>
					</div>
				</div>
				<%}%>
				
				<%if (!campanhasPassadas.isEmpty()) {%>
				<div class="w3-margin-top">
					<h6>Campanhas encerradas:</h6>
					<hr class="w3-margin-0 w3-margin-bottom">
					<div class="w3-accordion w3-light-grey">
					<% for (Campanha campanha : campanhasPassadas) { %>
						<button style="white-space: normal;" onclick="myFunction('<%=campanha.getCodigo()%>')" class="w3-btn-block w3-left-align w3-blue"><%=campanha.getNome()%> - De <%=df.format(campanha.getDataInicio())%> at� <%=df.format(campanha.getDataFim())%> <i class="fa fa-caret-down"></i></button>
						<div id="<%=campanha.getCodigo()%>" class="w3-accordion-content w3-container">
      						<p><i><%=campanha.getDescricao()%></i></p>
    					</div>
					<% } %>
					</div>
				</div>
				<%}%>
  			</div>
			<div class="w3-col l6 w3-padding-64">
			  <button style="width: 70%; white-space: normal;" onclick="document.getElementById('image-modal').style.display='block'" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge w3-margin-bottom">Clique para ver o Calend�rio de Vacina��o</button>
      		  <a href="./resources/calendars/2017.jpg" download="calendario_de_vacinacao">
			  	<button style="width: 70%; white-space: normal;" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge">Fa�a download do Calend�rio de Vacina��o</button>
			  </a>
  			</div>
  			<div id="image-modal" class="w3-modal">
			    <div class="w3-modal-content w3-animate-opacity w3-card-8">
			      <header class="w3-container"> 
			        <span onclick="document.getElementById('image-modal').style.display='none'" class="w3-closebtn">&times;</span>
			      </header>
			      <div class="w3-container">
			        <img src="./resources/calendars/2017.jpg" class="w3-image" alt="Calend�rio Nacional de Vacina��o de 2017">
			      </div>
			    </div>
			</div>
  		</div>

	</div>
	
	<script src="./resources/scripts/navigation.js"></script>
	<script>
		function myFunction(id) {
		    var x = document.getElementById(id);
		    if (x.className.indexOf("w3-show") == -1) {
		        x.className += " w3-show";
		    } else { 
		        x.className = x.className.replace(" w3-show", "");
		    }
		}
	</script>
</body>
</html>
