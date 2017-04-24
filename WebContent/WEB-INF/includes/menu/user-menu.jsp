<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
		String selecionado = request.getParameter("tipo");
    %>
    
	<div id="w3-top menu">
		<ul class="w3-navbar w3-light-grey w3-card-2" id="myNavbar">
			<li>
				<b><a href="/usuario-home" class="w3-large w3-wide">SCV</a></b>
			</li>

			<li class="w3-right w3-hide-medium w3-hide-small">
				<a <%if (selecionado.equals("1")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/usuario-dados">MEUS DADOS</a>
				<a <%if (selecionado.equals("2")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/usuario-registro">REGISTRAR VACINA��O</a>   
				<a <%if (selecionado.equals("3")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/usuario-cartao">CART�O DE VACINA��O</a> 
				<a <%if (selecionado.equals("4")) {%> class="w3-bottombar w3-border-blue" <%}%> href="/usuario-calendario">CALEND�RIO DE VACINA��O</a>
				<a class="w3-border-left" href="/logout">Sair <i class="fa fa-sign-out"></i></a>
			</li>

			<li class="w3-right"><a href="javascript:void(0)" class="w3-right w3-hide-large" onclick="w3_open()"> <i class="fa fa-bars w3-padding-right w3-padding-left"></i>
			</a></li>
		</ul>
	</div>

	<nav class="w3-sidenav w3-margin-0 w3-card-2 w3-blue w3-animate-left w3-hide-large" style="display: none" id="mySidenav">
		<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar �</a> 
		<a href="/usuario-dados" onclick="w3_close()">MEUS DADOS</a> 
		<a href="/usuario-registro" onclick="w3_close()">REGISTRAR VACINA��O</a>  
		<a href="/usuario-cartao" onclick="w3_close()">CART�O DE VACINA��O</a> 
		<a href="/usuario-calendario" onclick="w3_close()">CALEND�RIO DE VACINA��O</a>
		<a href="/logout" onclick="w3_close()">Sair</a>
	</nav>