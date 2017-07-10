package com.scv.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.entities.enums.Sexo;
import com.scv.entities.enums.TipoDocumento;
import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.javabean.Gerente;
import com.scv.javabean.Unidade;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.dao.GerenteDAO;
import com.scv.persistence.dao.UnidadeDAO;
import com.scv.persistence.exception.DAOException;

public class AdmGerenteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(AdmGerenteServlet.class.getName());
       
    public AdmGerenteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/adm/page-manager.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String codGerente;
		codGerente = request.getParameter("codGer");
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		try {
			String matricula = request.getParameter("matricula");
			String nome = request.getParameter("nome");
			Sexo sexo = Sexo.getByValue(request.getParameter("genero"));
			String nacionalidade = request.getParameter("nacionalidade");
			String naturalidade = request.getParameter("naturalidade");
			String cpf = request.getParameter("cpf");
			String documento = request.getParameter("documento");
			TipoDocumento tipoDocumento = TipoDocumento.getByValue(Integer.parseInt(request.getParameter("tipodoc")));
			String emissor = request.getParameter("emissor");
			Date dataNascimento = df.parse(request.getParameter("dtNascimento"));
			String telefone = request.getParameter("telefone");
			String email = request.getParameter("email");
			String logradouro = request.getParameter("endereco");
			String complemento = request.getParameter("complemento");
			String bairro = request.getParameter("bairro");
			Cidade cidade = CidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("cidade")));
			Estado estado = EstadoDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("estado")));
			String cep = request.getParameter("cep");
			Unidade unidade = UnidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("unidade")));
			Boolean status = Boolean.valueOf(request.getParameter("status"));
			
			if (!codGerente.isEmpty()) {
				Gerente gerente = GerenteDAO.getInstance().carregarPorCodigo(Integer.parseInt(codGerente));
				gerente.setNome(nome);
				gerente.setMatricula(matricula);
				gerente.setSexo(sexo);
				gerente.setNacionalidade(nacionalidade);
				gerente.setNaturalidade(naturalidade);
				gerente.setCpf(cpf);
				gerente.setDocumento(documento);
				gerente.setTipoDocumento(tipoDocumento);
				gerente.setEmissor(emissor);
				gerente.setDataNascimento(dataNascimento);
				gerente.setTelefone(telefone);
				gerente.setEmail(email);
				gerente.setLogradouro(logradouro);
				gerente.setComplemento(complemento);
				gerente.setBairro(bairro);
				gerente.setCidade(cidade);
				gerente.setEstado(estado);
				gerente.setCep(cep);
				gerente.setUnidade(unidade);
				gerente.setStatus(status);
				
				GerenteDAO.getInstance().alterar(gerente);
			} else {
				Gerente gerente = new Gerente(matricula, nome, sexo, nacionalidade, naturalidade, cpf,
						documento, tipoDocumento, emissor, dataNascimento, telefone, 
						email, logradouro, complemento, bairro, cidade, estado, 
						cep, unidade, status);
				
				GerenteDAO.getInstance().inserir(gerente);
			}
			
		} catch (ClassNotFoundException | DAOException | ParseException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		request.getRequestDispatcher("WEB-INF/adm/page-manager.jsp").forward(request, response);
		
	}

}
