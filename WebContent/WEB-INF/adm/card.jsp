<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="com.scv.persistence.dao.RegistroDAO"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Registro"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sistema de Controle de Vacinação - Cartão de Vacinação</title>
</head>
<body>

	<%
		Pessoa pessoa = (Pessoa) request.getAttribute("pessoa");
	
		Sexo sexoPessoa = pessoa.getSexo();
		String sexo = "Outro";
		String tipoDoc = "";
		String nDoc = "";
		
		if (sexoPessoa.getValue().equals("M")) {
			sexo = "Masculino";
		} else if (sexoPessoa.getValue().equals("F")) {
			sexo = "Feminino";
		} else if (sexoPessoa.getValue().equals("")) { 
			sexo = "Outro";
		}
		
		if (!pessoa.getDocumento().isEmpty()) {
			switch(pessoa.getTipoDocumento()) {
			case RG:
				tipoDoc = "RG";
				break;
			case CNH:
				tipoDoc = "CNH";
				break;
			case CTPS:
				tipoDoc = "CTPS";
				break;
			case PASSAPORTE:
				tipoDoc = "Passaporte";
				break;
			}
			nDoc = pessoa.getDocumento();
		} else {
			tipoDoc = "CPF";
			nDoc = pessoa.getCpf();
		}
		
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		List<Registro> registros = RegistroDAO.getInstance().carregarPorPessoa(pessoa);
		
	%>

	<div class="w3-container w3-padding-64">
			<div class="w3-padding">
				<div class="w3-row">
						<div class="w3-col w3-padding-tiny w3-center">
							<h5><b>CARTÃO DE VACINAÇÃO</b></h5>
						</div>
				</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Nome: </b><%=pessoa.getNome().toUpperCase()%></p> 
						</div>
					</div>
					
					<div class="w3-row">
						<div class="w3-col m4 l4">
							<p><b>Sexo: </b><%=sexo.toUpperCase()%></p> 
						</div>
					
						<div class="w3-col m4 l4">
							<p><b>Data de Nascimento: </b><%=df.format(pessoa.getDataNascimento())%></p>
						</div>
						
						<div class="w3-col m4 l4">
							<p><b>Nacionalidade: </b><%=pessoa.getNacionalidade()%></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Documento nacional de identificação: </b><%=tipoDoc%> - <%=nDoc%> - <%=pessoa.getEmissor()%></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Foi vacinado nas datas indicadas contra: </b></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<table class="w3-table w3-bordered w3-border">
								<tr>
									<th>Vacina</th><th>Data</th><th>Clínico ou agente de saúde responsável</th><th>Fabricante e número de lote</th><th>Validade</th><th>Unidade de Saúde</th>
								</tr>
								<%
									for (Registro r : registros) {
										if (r.getVerificado()) {
								%>
										<tr>
											<td><%=r.getVacina().getNome()%></td><td><%=df.format(r.getDataVacina())%></td><td><%=r.getConsulta().getVacinador().getNome() == null ? r.getVerificador().getNome() + " (verificado em " + df.format(r.getDataVerificacao()) + ")" : r.getConsulta().getVacinador().getNome() %></td><td><%=r.getLote()%></td><td><%=df.format(r.getDataValidade())%></td><td><%=r.getConsulta().getUnidade().getNomeFantasia()%></td>
										</tr>
								<%
										}
									}
								%>
							</table>
						</div>
					</div>
			</div>
		</div>
</body>
</html>