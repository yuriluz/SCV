<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.persistence.dao.CalendarioDAO"%>
<%@page import="com.scv.persistence.dao.RegistroDAO"%>
<%@page import="com.scv.javabean.Usuario.TipoUsuario"%>
<%@page import="com.scv.javabean.Gerente"%>
<%@page import="com.scv.javabean.Vacinador"%>
<%@page import="com.scv.javabean.Campanha"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="com.scv.javabean.Calendario"%>
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

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="3"/>
</jsp:include>

	<%
		TipoUsuario tipoUsuario = (TipoUsuario) session.getAttribute("tipoUsuario");
		List<Campanha> campanhas = new ArrayList<Campanha>();
		Estado estado;
		Cidade cidade;

		if (tipoUsuario.equals(TipoUsuario.GERENTE)) {
			Gerente gerente = (Gerente) session.getAttribute("gerente");
			estado = gerente.getUnidade().getEstado();
			cidade = gerente.getUnidade().getCidade();
			
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasNacionais());
			if (!estado.equals(null)){
				campanhas.addAll(CampanhaDAO.getInstance().carregarTodasPorEstado(estado));
			}
			if (!cidade.equals(null)){
				campanhas.addAll(CampanhaDAO.getInstance().carregarTodasPorCidade(cidade));
			}
		} else if (tipoUsuario.equals(TipoUsuario.VACINADOR)) {
			Vacinador vacinador = (Vacinador) session.getAttribute("vacinador");
			estado = vacinador.getUnidade().getEstado();
			cidade = vacinador.getUnidade().getCidade();
			
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasNacionais());
			if (!estado.equals(null)){
				campanhas.addAll(CampanhaDAO.getInstance().carregarTodasPorEstado(estado));
			}
			if (!cidade.equals(null)){
				campanhas.addAll(CampanhaDAO.getInstance().carregarTodasPorCidade(cidade));
			}
		} else if (tipoUsuario.equals(TipoUsuario.ADMINISTRADOR)) {
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodos());
		}
		
		Calendario calendarioAtual = CalendarioDAO.getInstance().carregarMaisAtual();
	
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

	<div class="w3-container w3-center w3-padding-32 w3-margin-right w3-margin-left">
		<div class="w3-row">
		  	<div class="w3-col l6">
    			<%if (!campanhasEmAndamento.isEmpty()) {%>
    			<div class="w3-margin-bottom">
					<p><b>Campanhas em andamento:</b><p>
					<table class="w3-table w3-bordered">
						    <tr>
      							<th>Campanha e local</th>
							    <th>Período</th>
    						</tr>					
					<% for (Campanha campanha : campanhasEmAndamento) { %>
							<tr class="w3-hover-blue">
						        <td><%=campanha.getNome()%> (<%if (campanha.getEstado().getCodigo() == null) {%>Nacional<%} else { if (campanha.getCidade().getCodigo() != null) {%><%=campanha.getCidade().getNome()%>, <%}%><%=campanha.getEstado().getUf()%><%}%>)</td>
						        <td>De <%=df.format(campanha.getDataInicio())%> até <%=df.format(campanha.getDataFim())%></td>
    						</tr>
					<% } %>
					</table>
				</div>
				<% } %>
				
    			<%if (!campanhasFuturas.isEmpty()) {%>
    			<div class="w3-margin-bottom">
					<p><b>Próximas campanhas:</b></p>
					<table class="w3-table w3-bordered">
						    <tr>
      							<th>Campanha e local</th>
							    <th>Período</th>
    						</tr>					
					<% for (Campanha campanha : campanhasFuturas) { %>
							<tr class="w3-hover-blue">
						        <td><%=campanha.getNome()%> (<%if (campanha.getEstado().getCodigo() == null) {%>Nacional<%} else { if (campanha.getCidade().getCodigo() != null) {%><%=campanha.getCidade().getNome()%>, <%}%><%=campanha.getEstado().getUf()%><%}%>)</td>
						        <td>De <%=df.format(campanha.getDataInicio())%> até <%=df.format(campanha.getDataFim())%></td>
    						</tr>
					<% } %>
					</table>
				</div>
				<% } %>
				
    			<%if (!campanhasPassadas.isEmpty()) {%>
    			<div class="w3-margin-bottom">
					<p><b>Campanhas encerradas:</b></p>
					<table class="w3-table w3-bordered">
						    <tr>
      							<th>Campanha e local</th>
							    <th>Período</th>
    						</tr>					
					<% for (Campanha campanha : campanhasPassadas) { %>
							<tr class="w3-hover-blue">
						        <td><%=campanha.getNome()%> (<%if (campanha.getEstado().getCodigo() == null) {%>Nacional<%} else { if (campanha.getCidade().getCodigo() != null) {%><%=campanha.getCidade().getNome()%>, <%}%><%=campanha.getEstado().getUf()%><%}%>)</td>
						        <td>De <%=df.format(campanha.getDataInicio())%> até <%=df.format(campanha.getDataFim())%></td>
    						</tr>
					<% } %>
					</table>
				</div>
				<% } %>
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
