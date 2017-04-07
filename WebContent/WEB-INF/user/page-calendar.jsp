<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.persistence.dao.CalendarioDAO"%>
<%@page import="com.scv.persistence.dao.RegistroDAO"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Campanha"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="com.scv.javabean.Calendario"%>
<%@page import="com.scv.javabean.Registro"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

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
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/user-menu.jsp">
	<jsp:param name="tipo" value="3"/>
</jsp:include>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
		Calendario calendarioAtual = CalendarioDAO.getInstance().carregarMaisAtual();
	
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
		List<Registro> registros = RegistroDAO.getInstance().carregarPorPessoa(usuario);
		
		Date hoje = new Date();
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		for (Campanha campanha : campanhas) {
			if (campanha.getDataInicio().compareTo(hoje) <= 0 && campanha.getDataFim().compareTo(hoje) >= 0) {
				if (usuario.getIdade() < campanha.getVacina().getIdadeMin() 
						||  usuario.getIdade() > campanha.getVacina().getIdadeMax()) {
					campanha.setMissingShot(false);
				} else {
					campanha.isUpToDate(registros);
				}
				campanhasEmAndamento.add(campanha);
			} else if (campanha.getDataInicio().after(hoje)) {
				if (usuario.getIdade() < campanha.getVacina().getIdadeMin() 
						||  usuario.getIdade() > campanha.getVacina().getIdadeMax()) {
					campanha.setMissingShot(false);
				} else {
					campanha.isUpToDate(registros);
				}
				campanhasFuturas.add(campanha);
			} else if (campanha.getDataFim().before(hoje)) {
				campanhasPassadas.add(campanha);
			}
		}
		
	%>

	<div class="w3-container w3-center w3-padding-64 w3-margin-right w3-margin-left">
		<div class="w3-row">
		  	<div class="w3-col l6">
    			<%if (!campanhasEmAndamento.isEmpty()) {%>
    			<div>
					<h6><b>Campanhas em andamento:</b></h6>
					<hr class="w3-margin-0 w3-margin-bottom">
					<div class="w3-accordion w3-light-blue">
					<% for (Campanha campanha : campanhasEmAndamento) { %>
						<button style="white-space: normal;" onclick="myFunction('<%=campanha.getCodigo()%>')" class="w3-btn-block w3-left-align w3-text-blue w3-white w3-leftbar w3-border-blue"><%if (campanha.getMissingShot()) {%><i class="w3-text-yellow fa fa-exclamation-triangle"></i><% } %> <%=campanha.getNome()%> - De <%=df.format(campanha.getDataInicio())%> até <%=df.format(campanha.getDataFim())%> <i class="fa fa-caret-down"></i></button>
						<div id="<%=campanha.getCodigo()%>" class="w3-accordion-content w3-container  w3-left-align">
      						<p><i><%=campanha.getDescricao()%></i></p>
      						<%if (campanha.getMissingShot()) {%>
      							<i class="fa fa-exclamation-triangle"></i> Você e/ou seu(s) dependente(s) precisam de uma dose dessa vacina!
      						<% } %>
    					</div>
					<% } %>
					</div>
				</div>
				<% } %>
				
				<%if (!campanhasFuturas.isEmpty()) {%>
				<div>
					<h6><b>Próximas campanhas:</b></h6>
					<hr class="w3-margin-0 w3-margin-bottom">
					<div class="w3-accordion w3-light-blue">
					<% for (Campanha campanha : campanhasFuturas) { %>
						<button style="white-space: normal;" onclick="myFunction('<%=campanha.getCodigo()%>')" class="w3-btn-block w3-left-align w3-text-blue w3-white w3-leftbar w3-border-blue"><%if (campanha.getMissingShot()) {%><i class="w3-text-yellow fa fa-exclamation-triangle"></i><% } %> <%=campanha.getNome()%> - De <%=df.format(campanha.getDataInicio())%> até <%=df.format(campanha.getDataFim())%> <i class="fa fa-caret-down"></i></button>
						<div id="<%=campanha.getCodigo()%>" class="w3-accordion-content w3-container w3-left-align">
      						<p><i><%=campanha.getDescricao()%></i></p>
      						<%if (campanha.getMissingShot()) {%>
      							<i class="fa fa-exclamation-triangle"> </i> Você e/ou seu(s) dependente(s) precisam de uma dose dessa vacina!
      						<% } %>
    					</div>
					<% } %>
					</div>
				</div>
				<%}%>
				
				<%if (!campanhasPassadas.isEmpty()) {%>
				<div>
					<h6><b>Campanhas encerradas:</b></h6>
					<hr class="w3-margin-0 w3-margin-bottom">
					<div class="w3-accordion w3-light-blue">
					<% for (Campanha campanha : campanhasPassadas) { %>
						<button style="white-space: normal;" onclick="myFunction('<%=campanha.getCodigo()%>')" class="w3-btn-block w3-left-align w3-text-blue w3-white w3-leftbar w3-border-blue"><%=campanha.getNome()%> - De <%=df.format(campanha.getDataInicio())%> até <%=df.format(campanha.getDataFim())%> <i class="fa fa-caret-down"></i></button>
						<div id="<%=campanha.getCodigo()%>" class="w3-accordion-content w3-container w3-left-align">
      						<p><i><%=campanha.getDescricao()%></i></p>
    					</div>
					<% } %>
					</div>
				</div>
				<%}%>
  			</div>
			<div class="w3-col l6 w3-padding-64">
			  <button style="width: 80%; white-space: normal;" onclick="document.getElementById('image-modal').style.display='block'" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge w3-margin-bottom w3-round">Clique para ver o Calendário de Vacinação de <%=calendarioAtual.getAno()%></button>
      		  <a href=<%=calendarioAtual.getImagem()%> download="calendario_de_vacinacao">
			  	<button style="width: 80%; white-space: normal;" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge w3-round">Faça download do Calendário de Vacinação de <%=calendarioAtual.getAno()%></button>
			  </a>
  			</div>
  			<div id="image-modal" class="w3-modal">
			    <div class="w3-modal-content w3-animate-opacity w3-card-8">
			      <header class="w3-container"> 
			        <span onclick="document.getElementById('image-modal').style.display='none'" class="w3-closebtn">&times;</span>
			      </header>
			      <div class="w3-container">
			        <img src=<%=calendarioAtual.getImagem()%> class="w3-image" alt="Calendário Nacional de Vacinação de <%=calendarioAtual.getAno()%>">
			      </div>
			    </div>
			</div>
  		</div>

	</div>
	
	<script src="./resources/scripts/navigation.js"></script>
	<script src="./resources/scripts/calendar.js"></script>
</body>
</html>
