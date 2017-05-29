<%@page import="com.scv.javabean.Usuario.TipoUsuario"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
		String selecionado = request.getParameter("selecionado");
    	TipoUsuario tipoUsuario = (TipoUsuario) session.getAttribute("tipoUsuario");
    %>
    
	<div id="w3-top menu">
		<ul class="w3-navbar w3-light-grey w3-card-2" id="myNavbar">
			<li>
				<b><a href="/inicial" class="w3-large w3-wide">SCV</a></b>
			</li>
	<% if (tipoUsuario.equals(TipoUsuario.VACINADOR)) { %>
			<li class="w3-right w3-hide-medium w3-hide-small">
				<a class="w3-border-left" href="/logout">Sair <i class="fa fa-sign-out"></i></a>
			</li>
			<div class="w3-dropdown-hover w3-right w3-padding-top w3-hide-medium w3-hide-small">
				<button class="w3-button">VACINAÇÃO</button>
				<div class="w3-dropdown-content w3-bar-block w3-card-4">
					<a href="/cartao" class="w3-bar-item w3-button">CARTÃO DE VACINAÇÃO</a>
				    <a href="/calendario" class="w3-bar-item w3-button">CALENDÁRIO DE VACINAÇÃO</a>
				    <a href="/registro" class="w3-bar-item w3-button">REGISTRAR VACINAÇÃO</a>
				    <a href="/confirmacao" class="w3-bar-item w3-button">CONFIRMAR VACINAÇÃO</a>
				</div>
			</div>
			<li class="w3-right w3-hide-medium w3-hide-small">
				<a <%if (selecionado.equals("1")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/pessoa">CADASTRO DE PESSOAS</a> 
				<!-- <a <%if (selecionado.equals("2")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/cartao">CARTÃO DE VACINAÇÃO</a> 
				<a <%if (selecionado.equals("3")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/calendario">CALENDÁRIO DE VACINAÇÃO</a>
				<a <%if (selecionado.equals("4")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/registro">REGISTRAR VACINAÇÃO</a>
				<a <%if (selecionado.equals("5")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/confirmacao">CONFIRMAR VACINAÇÃO</a>  -->
				<a <%if (selecionado.equals("9")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/senha">ALTERAR SENHA</a>
			</li>
	<% } else if (tipoUsuario.equals(TipoUsuario.GERENTE)) { %>
			<li class="w3-right w3-hide-medium w3-hide-small"> 
				<a <%if (selecionado.equals("2")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/cartao">CARTÃO DE VACINAÇÃO</a> 
				<a <%if (selecionado.equals("3")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/calendario">CALENDÁRIO DE VACINAÇÃO</a>
				<a <%if (selecionado.equals("6")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/agente">CADASTRO DE AGENTE</a>
				<a <%if (selecionado.equals("9")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/senha">ALTERAR SENHA</a>

				<a class="w3-border-left" href="/logout">Sair <i class="fa fa-sign-out"></i></a>
			</li>
	<% } else if (tipoUsuario.equals(TipoUsuario.ADMINISTRADOR)) { %>
			<li class="w3-right w3-hide-medium w3-hide-small">
				<a <%if (selecionado.equals("7")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/unidade">CADASTRO DE UNIDADE</a> 
				<a <%if (selecionado.equals("8")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/gerente">CADASTRO DE GERENTE</a>
				<a <%if (selecionado.equals("9")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/senha">ALTERAR SENHA</a> 

				<a class="w3-border-left" href="/logout">Sair <i class="fa fa-sign-out"></i></a>
			</li>
	<% } else { %>
			<li class="w3-right w3-hide-medium w3-hide-small">
				<a class="w3-border-left" href="/logout">Sair <i class="fa fa-sign-out"></i></a>
			</li>
	<% }  %>

			<li class="w3-right"><a href="javascript:void(0)" class="w3-right w3-hide-large" onclick="w3_open()"> <i class="fa fa-bars w3-padding-right w3-padding-left"></i>
			</a></li>
		</ul>
	</div>

	<% if (tipoUsuario.equals(TipoUsuario.VACINADOR)) { %>
		<nav class="w3-sidenav w3-margin-0 w3-card-2 w3-blue w3-animate-left w3-hide-large" style="display: none" id="mySidenav">
			<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> 
			<a href="/pessoa" onclick="w3_close()">CADASTRO DE PESSOAS</a> 
			<a href="/cartao" onclick="w3_close()">CARTÃO DE VACINAÇÃO</a> 
			<a href="/calendario" onclick="w3_close()">CALENDÁRIO DE VACINAÇÃO</a>
			<a href="/registro" onclick="w3_close()">REGISTRAR VACINAÇÃO</a> 
			<a href="/confirmacao" onclick="w3_close()">CONFIRMAR VACINAÇÃO</a>
			<a href="/senha" onclick="w3_close()">ALTERAR SENHA</a>   
			<a href="/logout" onclick="w3_close()">Sair</a>
		</nav>
	<% } else if (tipoUsuario.equals(TipoUsuario.GERENTE)) { %>
		<nav class="w3-sidenav w3-margin-0 w3-card-2 w3-blue w3-animate-left w3-hide-large" style="display: none" id="mySidenav">
			<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> 
			<a href="/cartao" onclick="w3_close()">CARTÃO DE VACINAÇÃO</a> 
			<a href="/calendario" onclick="w3_close()">CALENDÁRIO DE VACINAÇÃO</a>
			<a href="/agente" onclick="w3_close()">CADASTRO DE AGENTE</a>
			<a href="/senha" onclick="w3_close()">ALTERAR SENHA</a> 
			<a href="/logout" onclick="w3_close()">Sair</a>
		</nav>
	<% } else if (tipoUsuario.equals(TipoUsuario.ADMINISTRADOR)) { %>
		<nav class="w3-sidenav w3-margin-0 w3-card-2 w3-blue w3-animate-left w3-hide-large" style="display: none" id="mySidenav">
			<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> 
			<a href="/unidade" onclick="w3_close()">CADASTRO DE UNIDADE</a> 
			<a href="/gerente" onclick="w3_close()">CADASTRO DE GERENTE</a>
			<a href="/senha" onclick="w3_close()">ALTERAR SENHA</a>   
			<a href="/logout" onclick="w3_close()">Sair</a>
		</nav>
	<% } else { %>
		<nav class="w3-sidenav w3-margin-0 w3-card-2 w3-blue w3-animate-left w3-hide-large" style="display: none" id="mySidenav">
			<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> 
			<a href="/logout" onclick="w3_close()">Sair</a>
		</nav>
	<% }  %>