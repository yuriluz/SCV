<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.UnidadeDAO"%>
<%@page import="com.scv.javabean.Usuario"%>
<%@page import="com.scv.javabean.Unidade"%>
<%@page import="com.scv.javabean.Unidade.TipoUnidade"%>
<%@page import="com.scv.javabean.Unidade.Gestao"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>

	<%
		Usuario usuario = (Usuario) session.getAttribute("login");
		Unidade unidade = (Unidade) request.getAttribute("unidade");
		Estado estado = unidade.getEstado();
		Cidade cidade = unidade.getCidade();
		TipoUnidade tipo = unidade.getTipo();
		Gestao gestao = unidade.getGestao();
	%>	
				<div class="w3-row">
					<div class="w3-col m6 l5 w3-padding-small">
						<label><b>Selecione a unidade</b></label>
						<select class="w3-input" id="unidade" name="unidade">
							<option value=""></option>
									<%
										List<Unidade> unidades = new ArrayList<Unidade>();
										unidades = UnidadeDAO.getInstance().carregarPorUsuario(usuario);
	
										for (Unidade u : unidades) {
									%>
									<option value=<%=u.getCodigo()%> <% if (u.getCodigo().equals(unidade.getCodigo())) { %>selected<% } %>><%=u.getCodigo()%> - <%=u.getNomeFantasia()%></option>
									<%
										}
									%>
						</select>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/unidade">
					<input type="hidden" id="codUni" name="codUni" value=<%=unidade.getCodigo()%>>
					<input type="hidden" id="codUser" name="codUser" value=<%=usuario.getCodigo() %>>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Nome Fantasia</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=unidade.getNomeFantasia()%>" required>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Razão Social</b></label> <input class="w3-input" type="text" id="razao" name="razao" value="<%=unidade.getRazaoSocial()%>" required>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CNES</b></label> <input class="w3-input" type="text" id="cnes" name="cnes" value="<%=unidade.getCnes()%>" required>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CNPJ</b></label> <input class="w3-input" type="text" id="cnpj" name="cnpj" value="<%=unidade.getCnpj()%>" required>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=unidade.getLogradouro()%>" required>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=unidade.getBairro()%>" required>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=unidade.getCep()%>" required>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado">
								<%
									List<Estado> estados = new ArrayList<Estado>();
									estados = EstadoDAO.getInstance().carregarTodos();

									for (Estado e : estados) {
								%>
								<option value=<%=e.getCodigo()%> <%if (e.getCodigo().equals(estado.getCodigo())) {%> selected <%}%>><%=e.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" >
								<%
									List<Cidade> cidades = new ArrayList<Cidade>();
									cidades = CidadeDAO.getInstance().carregarPorEstado(estado);

									for (Cidade c : cidades) {
								%>
								<option value=<%=c.getCodigo()%> <%if (c.getCodigo().equals(cidade.getCodigo())) {%> selected <%}%>><%=c.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=unidade.getTelefone()%>" required>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Tipo da Unidade</b></label> <select class="w3-input" id="tipouni" name="tipouni">
								<option value="H" <%if (tipo.getValue().equals("H")) {%> selected <%}%>>Hospital</option>
								<option value="P" <%if (tipo.getValue().equals("P")) {%> selected <%}%>>Centro de Saúde</option>
								<option value="C" <%if (tipo.getValue().equals("C")) {%> selected <%}%>>Clínica</option>
							</select>
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Tipo de Gestão</b></label> <select class="w3-input" id="gestao" name="gestao">
								<option value="P" <%if (gestao.getValue().equals("P")) {%> selected <%}%>>Particular</option>
								<option value="M" <%if (gestao.getValue().equals("M")) {%> selected <%}%>>Municipal</option>
								<option value="E" <%if (gestao.getValue().equals("E")) {%> selected <%}%>>Estadual</option>
								<option value="D" <%if (gestao.getValue().equals("D")) {%> selected <%}%>>Dupla</option>
								<option value="F" <%if (gestao.getValue().equals("F")) {%> selected <%}%>>Federal</option>
								<option value="T" <%if (gestao.getValue().equals("T")) {%> selected <%}%>>Militar</option>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Status</b></label> <select class="w3-input" id="status" name="status">
								<option value="true" <%if (unidade.getStatus()) { %> selected <% } %>>Ativo</option>
								<option value="false" <%if (!unidade.getStatus()) { %> selected <% } %>>Inativo</option>
							</select>
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right">
								<i class="fa fa-floppy-o"></i> SALVAR ALTERAÇÕES
							</button>
						</div>
					</div>
				</form>

