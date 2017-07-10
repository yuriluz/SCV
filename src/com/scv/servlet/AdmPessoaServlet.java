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
import com.scv.javabean.Pessoa;
import com.scv.javabean.Pessoa.Escolaridade;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.dao.PessoaDAO;
import com.scv.persistence.exception.DAOException;

public class AdmPessoaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(AdmPessoaServlet.class.getName());
       
    public AdmPessoaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/adm/page-user.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String codPessoa;
		codPessoa = request.getParameter("codPessoa");
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		try {
			String nome = request.getParameter("nome");
			Sexo sexo = Sexo.getByValue(request.getParameter("genero"));
			String nacionalidade = request.getParameter("nacionalidade");
			String naturalidade = request.getParameter("naturalidade");
			String cpf = request.getParameter("cpf");
			String documento = request.getParameter("documento");
			TipoDocumento tipoDocumento = TipoDocumento.getByValue(Integer.parseInt(request.getParameter("tipodoc")));
			String emissor = request.getParameter("emissor");
			Date dataNascimento = df.parse(request.getParameter("dtNascimento"));
			Escolaridade escolaridade = Escolaridade.getByValue(Integer.parseInt(request.getParameter("escolaridade")));
			String telefone = request.getParameter("telefone");
			String email = request.getParameter("email");
			String logradouro = request.getParameter("endereco");
			String complemento = request.getParameter("complemento");
			String bairro = request.getParameter("bairro");
			Cidade cidade = CidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("cidade")));
			Estado estado = EstadoDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("estado")));
			String cep = request.getParameter("cep");
			
			if (!codPessoa.isEmpty()) {
				Pessoa pessoa = PessoaDAO.getInstance().carregarPorCodigo(Integer.parseInt(codPessoa));
				pessoa.setNome(nome);
				pessoa.setSexo(sexo);
				pessoa.setNacionalidade(nacionalidade);
				pessoa.setNaturalidade(naturalidade);
				pessoa.setCpf(cpf);
				pessoa.setDocumento(documento);
				pessoa.setTipoDocumento(tipoDocumento);
				pessoa.setEmissor(emissor);
				pessoa.setDataNascimento(dataNascimento);
				pessoa.setEscolaridade(escolaridade);
				pessoa.setTelefone(telefone);
				pessoa.setEmail(email);
				pessoa.setLogradouro(logradouro);
				pessoa.setComplemento(complemento);
				pessoa.setBairro(bairro);
				pessoa.setCidade(cidade);
				pessoa.setEstado(estado);
				pessoa.setCep(cep);
				
				PessoaDAO.getInstance().alterar(pessoa);
			} else {
				Pessoa pessoa = new Pessoa(nome, sexo, nacionalidade, naturalidade, cpf, documento, 
						tipoDocumento, emissor, dataNascimento, escolaridade, telefone, email, logradouro, 
						complemento, bairro, cidade, estado, cep);
				
					PessoaDAO.getInstance().inserir(pessoa);
			}
			
		} catch (ClassNotFoundException | DAOException | ParseException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		request.getRequestDispatcher("WEB-INF/adm/page-user.jsp").forward(request, response);
		
	}

}
