<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.entities.enums.TipoDocumento"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Campanha"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		String nome = usuario.getNome().substring(0, usuario.getNome().indexOf(" ")).toUpperCase();
		Sexo genero = usuario.getSexo();
		Escolaridade escolaridade = usuario.getEscolaridade();
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
		TipoDocumento tipoDocumento = usuario.getTipoDocumento();
		
		List<Pessoa> cadastros = new ArrayList<Pessoa>();
		cadastros.add(usuario);

	%>

					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nome</label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=usuario.getNome()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Data de Nascimento</label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=usuario.getDataNascimento()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Gênero</label> <select class="w3-input" id="genero" name="genero">
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nível de Escolaridade</label> <select class="w3-input" id="escolaridade" name="escolaridade">
								<option value=0 <%if (escolaridade.getValue() == 0) {%> selected <%}%>>Não possui</option>
								<option value=1 <%if (escolaridade.getValue() == 1) {%> selected <%}%>>Fundamental</option>
								<option value=2 <%if (escolaridade.getValue() == 2) {%> selected <%}%>>Médio</option>
								<option value=3 <%if (escolaridade.getValue() == 3) {%> selected <%}%>>Superior Incompleto</option>
								<option value=4 <%if (escolaridade.getValue() == 4) {%> selected <%}%>>Superior Completo</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-tiny">
							<label>CPF</label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=usuario.getCpf()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-tiny">
							<label>Naturalidade</label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=usuario.getNaturalidade()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-tiny">
							<label>Nacionalidade</label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=usuario.getNacionalidade()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-tiny">
							<label>Tipo do Documento</label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1" <%if (tipoDocumento.getValue().equals(1)) {%> selected <%}%>>RG</option>
								<option value="2" <%if (tipoDocumento.getValue().equals(2)) {%> selected <%}%>>Passaporte</option>
								<option value="3" <%if (tipoDocumento.getValue().equals(3)) {%> selected <%}%>>CNH</option>
								<option value="4" <%if (tipoDocumento.getValue().equals(4)) {%> selected <%}%>>CTPS</option>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-tiny">
							<label>Número do Documento</label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=usuario.getDocumento()%>">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-tiny">
							<label>Órgão Emissor</label> <input class="w3-input" type="text" id="emissor" name="emissor" value="<%=usuario.getEmissor()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Endereço</label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=usuario.getLogradouro()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Complemento</label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=usuario.getComplemento()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Bairro</label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=usuario.getBairro()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>CEP</label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=usuario.getCep()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Estado</label> <select class="w3-input" id="estado" name="estado">
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

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Cidade</label> <select class="w3-input" id="cidade" name="cidade" >
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

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Telefone</label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=usuario.getTelefone()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>E-mail</label> <input class="w3-input" type="text" id="email" name="email" value="<%=usuario.getEmail()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="reset" id="saveButton" class="w3-btn w3-white w3-border w3-hover-blue w3-right" disabled>
								SALVAR ALTERAÇÕES <i class="fa fa-floppy-o"></i>
							</button>
						</div>
					</div>

