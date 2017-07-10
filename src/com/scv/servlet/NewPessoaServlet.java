package com.scv.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

public class NewPessoaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewPessoaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
			String senha = request.getParameter("senha1");
			
			
			Pessoa pessoa = new Pessoa(nome, sexo, nacionalidade, naturalidade, cpf, documento, 
						tipoDocumento, emissor, dataNascimento, escolaridade, telefone, email, logradouro, 
						complemento, bairro, cidade, estado, cep, senha);
				
			PessoaDAO.getInstance().inserir(pessoa);
			request.getRequestDispatcher("user-registration.jsp?sucesso=1").forward(request, response);

			
		} catch (ClassNotFoundException | DAOException | ParseException e) {
			request.getRequestDispatcher("user-registration.jsp?sucesso=0").forward(request, response);
		}
		
	}

}
